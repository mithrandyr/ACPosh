Param(
    [Parameter()][string]$BaseURL = "https://gitlab.com/Scribble/gdlenhanced/-/archive/{0}/gdlenhanced-master.zip"
    , [Parameter()][ValidateSet("master","TestServer")][string]$Branch = "master"
    , [Parameter(Mandatory)][string]$ExtractLocation
)

[string]$Url = $BaseURL -f $Branch
[string]$DestZip = Join-Path $env:TEMP "GDLE-Repo.zip"

Write-Host "Grabbing from '$url' and extracting to '$ExtractLocation'..."
if(-not (Test-Path $ExtractLocation)) {
    Write-Host "Creating Directory: $ExtractLocation"
    New-Item $ExtractLocation -ItemType Directory -Force | Out-Null    
}

Write-Host "Downloading Repo as ZIP..."
Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $DestZip

Write-Host "Expanding Repo..."
Expand-Archive -Path $DestZip -DestinationPath $ExtractLocation

Write-Host "Rearranging files..."
Get-ChildItem -Directory -Path $ExtractLocation |
    ForEach-Object {
        $fld = $_
        $fld | Get-ChildItem | Move-Item -Destination $ExtractLocation
        $fld | Remove-Item
    }

Write-Host "Done!"