param([int]$NumberOfThreads = 16
    , [datetime]$UpdatedAfter = "2020-03-14"
    , [string]$DestinationPath = "E:\Games\ACServer\Data\json\weenies")

<#
TODO
    - Don't record all wcids -- just counts
    - double check which ones are being flagged to save to disk (date seems off)
#>

[scriptblock]$SB = {
    Param([int[]]$list, [datetime]$check, [string]$DownloadFolder, [System.Collections.Generic.List[System.Management.Automation.PSObject]]$resultList)
    [string]$LSDLink = "https://www.lifestoned.org/Weenie/DownloadOriginal?id={0}"
    
    $results = [PSCustomObject]@{
        Success = 0
        FailureOld = 0
        FailureNotDone = 0
        FailureNonExistent = 0
        Time = 0.0
    }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $c = 0
    foreach($wcid in $list) {
        Write-Progress -Activity "Processing WCIDs..." -CurrentOperation $wcid -PercentComplete (100 * $c / $list.count)
        $data = Invoke-WebRequest -UseBasicParsing -Uri ($LSDLink -f $wcid)
        if($data.Headers.ContainsKey("Content-Disposition")) {
            [string]$fileName = ($data.Headers["Content-Disposition"] -split "filename=")[1] -replace '"'
            $fileName = Join-Path $DownloadFolder $fileName
            $json = $data.Content | ConvertFrom-Json
            if($json.isDone) {
                if([datetime]$json.lastModified -gt $check) {
                    Set-Content -Path $fileName -Value $data.Content -Force
                    $results.Success += 1
                }
                else { $results.FailureOld += 1 }
            }
            else { $results.FailureNotDone += 1 }
        }
        else { $results.FailureNonExistent += 1 }
        $c += 1
    }
    $sw.Stop()
    Write-Progress -Activity "Processing WCIDs..." -Completed
    $results.Time = $sw.Elapsed.TotalSeconds
    $sw = $null
    $resultList.Add($results)
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
        JobList = [System.Collections.Generic.List[System.Management.Automation.Job2]]::new()
        KeepRunning = $true
        Results = [System.Collections.Generic.List[System.Management.Automation.PSObject]]::new()
        Timer = [System.Diagnostics.Stopwatch]::StartNew()
    } |
    Add-Member -MemberType ScriptProperty -Name "ElapsedThreadTime" -Value {($this.Results | Measure-Object -Sum Time).Sum} -PassThru |
    Add-Member -MemberType ScriptProperty -Name "ThreadFactor" -Value { [math]::round($this.ElapsedThreadTime / $this.Timer.Elapsed.TotalSeconds, 2)} -PassThru |
    Add-Member -MemberType ScriptProperty -Name "WeenieUpdatedCount" -Value {$this.Results.Success.Count} -PassThru

Start-ThreadJob -Name "GetLatestLifestoned" -ThrottleLimit ($NumberOfThreads + 1) -ScriptBlock $watcher -StreamingHost $host -ArgumentList $watcherObject | Out-Null
$maxId = 100000

[int[]]$wcidList = @(1..$maxId | Get-Random -Count $maxId)
$c = 1
while($c -le $maxId) {
    $watcherObject.JobList.Add((Start-ThreadJob -ScriptBlock $SB -ArgumentList $wcidList[$c..($c+49)], $UpdatedAfter, $DestinationPath, $watcherObject.Results -Name "WCID-Download"))
    $c += 50
}
$watcherObject