Param([string]$BuildFolder
    , [string]$ServerFolder)
$ErrorActionPreference = "Stop"
[string[]]$filesToCopy = @("GDLELogging.conf","GDLEnhanced.exe","GDLEnhanced.pdb","libmysql.dll")

foreach ($f in $filesToCopy) {
    Join-Path -Path $BuildFolder -ChildPath $f | Copy-Item -Destination $ServerFolder -Verbose
}

$BuildDataFolder = Join-Path $BuildFolder "Data"
$ServerDataFolder = Join-Path $ServerFolder "Data"

Get-ChildItem -Path $BuildDataFolder -Recurse -File -Name |
    ForEach-Object {
        Copy-Item -Path (Join-Path $BuildDataFolder $_) -Destination (Join-Path $ServerDataFolder $_) -Force -Verbose
    }