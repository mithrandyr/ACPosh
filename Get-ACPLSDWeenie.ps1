Param([Parameter(Mandatory)][string]$DownloadFolder
    , [Parameter(ValueFromPipeline)][ValidateRange(1,99999)][int]$WCID
    , [switch]$All
    , [switch]$Silent
)

begin {
    [string]$LSDLink = "https://www.lifestoned.org/Weenie/DownloadOriginal?id={0}"
    if(-not (Test-Path $DownloadFolder -PathType Container)) {
        throw "Directory not found! ($DownloadFolder)"
    }
}

process { 
    if(-not $Silent) { Write-Host "Processing Weenie #$WCID..." -NoNewline }
    
    $result = Invoke-WebRequest -UseBasicParsing -Uri ($LSDLink -f $WCID)
    if($result.Headers.ContainsKey("Content-Disposition")) {
        if($All -or ($result.Content | ConvertFrom-Json).isDone){
            [string]$name = ($result.Headers["Content-Disposition"] -split "filename=")[1] -replace '"'
            Set-Content -Path (Join-Path $DownloadFolder $name) -Value $result.Content -Force
            if(-not $silent) { Write-Host "Completed!" -ForegroundColor Green }
            else { $true }
        }
        else {
            if(-not $silent) { Write-Host "Skipped!" -ForegroundColor Yellow }
            else { $false }
        }
    }
    else {
        if(-not $silent) { Write-Host "Failed (not valid weenie)!" -ForegroundColor Red }
        else { $false }
    }
}