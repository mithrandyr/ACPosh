Param([Parameter(Mandatory)][string]$DownloadFolder
    , [Parameter(ValueFromPipeline)][ValidateRange(1,99999)][int]$WCID
    , [switch]$All
)

begin {
    [string]$LSDLink = "https://www.lifestoned.org/Weenie/DownloadOriginal?id={0}"
    [int[]]$weenieList = @()
    if(-not (Test-Path $DownloadFolder -PathType Container)) {
        throw "Directory not found! ($DownloadFolder)"
    }
}

process { $weenieList += $WCID }

end {
    foreach($id in $weenieList) {
        Write-Host "Processing Weenie #$id..." -NoNewline
        $result = Invoke-WebRequest -UseBasicParsing -Uri ($LSDLink -f $id)
        if($result.Headers.ContainsKey("Content-Disposition")) {
            if($All -or ($result.Content | ConvertFrom-Json).isDone){
                [string]$name = ($result.Headers["Content-Disposition"] -split "filename=")[1] -replace '"'
                Set-Content -Path (Join-Path $DownloadFolder $name) -Value $result.Content -Force
                Write-Host "Completed!" -ForegroundColor Green
            }
            else { Write-Host "Skipped!" -ForegroundColor Yellow }
        }
        else { Write-Host "Failed (not valid weenie)!" -ForegroundColor Red }
    }    
}