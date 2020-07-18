param([int]$NumberOfThreads = 4
    , [datetime]$UpdatedAfter = "2020-03-14"
    , [string]$DestinationPath = "E:\Games\ACServer\Data\json\weenies"
    , [switch]$All
    , [int]$StartWCID = 1
    , [int]$StopWCID = 99999)

[scriptblock]$SB = {
    Param([System.Management.Automation.PSObject]$Manager, [datetime]$check, [string]$DownloadFolder, [bool]$All)
    [string]$LSDLink = "https://www.lifestoned.org/Weenie/DownloadOriginal?id={0}"
    
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $c = 0
    $manager.Remaining = $manager.WCIDs.Count
    foreach($wcid in $Manager.WCIDs) {
        if($manager.Cancel) { break }
        Write-Progress -Activity "Processing WCIDs..." -CurrentOperation $wcid -PercentComplete (100 * $c / $list.count)
        $data = Invoke-WebRequest -UseBasicParsing -Uri ($LSDLink -f $wcid)
        if($data.Headers.ContainsKey("Content-Disposition")) {
            [string]$fileName = ($data.Headers["Content-Disposition"] -split "filename=")[1] -replace '"'
            $fileName = Join-Path $DownloadFolder $fileName
            $json = $data.Content | ConvertFrom-Json
            if($json.isDone -or $All) {
                if(([datetime]$json.lastModified -gt $check) -or $All) {
                    Set-Content -Path $fileName -Value $data.Content -Force
                    $manager.Success += 1
                }
                else { $manager.Old += 1 }
            }
            else { $manager.NotDone += 1 }
        }
        else { $manager.Missing += 1 }
        $c += 1
        $manager.Completed += 1
        $manager.Remaining -= 1
        $manager.Time += $sw.Elapsed.TotalSeconds
        $sw.restart()
    }
    $sw.Stop()
    Write-Progress -Activity "Processing WCIDs..." -Completed
    $manager.Time = $sw.Elapsed.TotalSeconds
    $Manager.IsDone = $true
    $sw = $null
}

[scriptblock]$watcher = {
    param($obj)
    $initTitle = $host.UI.RawUI.WindowTitle
    Start-Sleep -Seconds 1
    $c = 4
    while($obj.KeepRunning) {
        $c -= 1
        if($c -eq 1) {
            $c = 4
            $ToGo = $obj.Results.Remaining
            $ToGo = $ToGo | Measure-Object -Sum | Select-Object -ExpandProperty Sum

            if($ToGo -eq 0) { write-host "breaking..."; break }
            else {
                $completed = $obj.Results.Completed
                $completed = $completed | Measure-Object -Sum | Select-Object -ExpandProperty Sum
                $eta = [math]::round($obj.Timer.Elapsed.TotalSeconds / $completed * $ToGo,0)
                $etaS = $eta % 60
                $etaM = ($eta - $etas) / 60

                $host.UI.RawUI.WindowTitle = "{0} - Completed: {1}% | {2} Remaining | Rate: {3} | ETA: {4}m {5}s" -f $initTitle, [int](100 * $Completed / ($Completed + $ToGo)), $ToGo, $obj.Rate, $etaM, $etaS
            }
        }
        Start-Sleep -Milliseconds 500
    }
    $host.UI.RawUI.WindowTitle = $initTitle
    $obj.Timer.Stop()
}

$watcherObject = [PSCustomObject]@{
        KeepRunning = $true    
        Results = (1..$NumberOfThreads) | ForEach-Object {[PSCustomObject]@{
            Success = 0
            Old = 0
            NotDone = 0
            Missing = 0
            Time = 0.0
            IsDone = $false
            Cancel = $false
            WCIDs = @()
            Job = $null
            Completed = 0
            Remaining = 0
        }}
        Timer = [System.Diagnostics.Stopwatch]::StartNew()
        WatcherJob = $null
    } |
    Add-Member -MemberType ScriptProperty -Name "ElapsedThreadTime" -Value {$this.Results | Measure-Object -Sum -Property Time | ForEach-Object Sum } -PassThru |
    Add-Member -MemberType ScriptProperty -Name "Rate" -Value { [math]::round(($this.Results | Measure-Object -Sum -Property Completed).Sum / $this.Timer.Elapsed.TotalSeconds, 1)} -PassThru |
    Add-Member -MemberType ScriptProperty -Name "WeenieUpdatedCount" -Value {$this.Results | Measure-Object -Sum -Property Success | ForEach-Object Sum } -PassThru |
    Add-Member -MemberType ScriptMethod -Name "Cancel" -Value {
        $this.KeepRunning = $false
        $this.Results | Where-Object IsDone -eq $false | ForEach-Object {$_.Cancel = $true}
        while($this.Results | Where-Object {$_.Job.State -ne "Completed"}) { Write-Host "." -NoNewLine; Start-Sleep -Milliseconds 250 }
        $this.Results.Job | Stop-Job
        $this.Results.Job | Remove-Job
        Stop-Job $this.WatcherJob
        Remove-Job $this.WatcherJob
        $this.Timer.Stop()
    } -PassThru

$watcherObject.WatcherJob = Start-ThreadJob -Name "GetLatestLifestoned" -ThrottleLimit ($NumberOfThreads + 1) -ScriptBlock $watcher -StreamingHost $host -ArgumentList $watcherObject

[int[]]$wcidList = @($StartWCID..$StopWCID | Get-Random -Count ($StopWCID - $StartWCID))
$batchSize = [math]::Truncate(($StopWCID - $StartWCID) / $NumberOfThreads) + 1

1..$NumberOfThreads | ForEach-Object {
    $c = $_ - 1
    $s = $c * $batchSize
    $e = $s + $batchSize - 1
    $subProcess = $watcherObject.Results[$c]
    $subProcess.WCIDs = $wcidList[$s..$e]
    $subProcess.Job = Start-ThreadJob -ScriptBlock $SB -ArgumentList $subProcess, $UpdatedAfter, $DestinationPath, $All.IsPresent -Name "WCID-Download"
}
$watcherObject