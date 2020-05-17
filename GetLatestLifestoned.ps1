param([int]$NumberOfThreads = 32
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
    foreach($wcid in $list) {
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
        $manager.Time += $sw.Elapsed.TotalSeconds
        $sw.restart()
    }
    $sw.Stop()
    Write-Progress -Activity "Processing WCIDs..." -Completed
    $manager.Time = $sw.Elapsed.TotalSeconds
    $sw = $null
}

[scriptblock]$watcher = {
    param($obj)
    $initTitle = $host.UI.RawUI.WindowTitle
    Start-Sleep -Seconds 1
    while($obj.KeepRunning) {
        $Completed = $obj.JobList.where({$_.State -eq "Completed"}).Count
        $ToGo = $obj.JobList.where({$_.State -ne "Completed"}).Count

        if($ToGo -eq 0) { break }
        else { $host.UI.RawUI.WindowTitle = "{0} - Completed: {1}% | {2} Remaining" -f $initTitle, [int](100 * $Completed / ($Completed + $ToGo)), $ToGo }
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
        }}
        Timer = [System.Diagnostics.Stopwatch]::StartNew()
        WatcherJob = $null
    } |
    Add-Member -MemberType ScriptProperty -Name "ElapsedThreadTime" -Value {$this.Results | Measure-Object -Sum -Property Time | ForEach-Object Time } -PassThru |
    Add-Member -MemberType ScriptProperty -Name "ThreadFactor" -Value { [math]::round($this.ElapsedThreadTime / $this.Timer.Elapsed.TotalSeconds, 2)} -PassThru |
    Add-Member -MemberType ScriptProperty -Name "WeenieUpdatedCount" -Value {$this.Results | Measure-Object -Sum -Property Success | ForEach-Object Success } -PassThru |
    Add-Member -MemberType ScriptMethod -Name "Cancel" -Value {
        $this.KeepRunning = $false
        $this.Results | Where-Object IsDone -eq $false | ForEach-Object {$_.Cancel = $true}
        while($this.Results | Where-Object IsDone -eq $false) { Write-Host "." -NoNewLine; Start-Sleep -Milliseconds 250 }
        $this.Results.Job | Stop-Job
        $this.Results.Job | Remove-Job
        Stop-Job $this.WatcherJob
        Remove-Job $this.WatcherJob
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
Remove-Variable subProcess
$watcherObject