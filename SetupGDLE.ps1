param([string]$build="master")

$ErrorActionPreference = "Stop"
# Grab the latest Repo and extract. -- make sure to update location to extract to
& "$PSScriptRoot\Get-GDLERepo.ps1" -ExtractLocation "E:\Games\TestAcServer" -branch $build

#run build
& "$PSScriptRoot\Invoke-GDLEBuild.ps1" -workingDir "E:\Games\TestAcServer"

#Deploy build
& "$PSScriptRoot\Copy-GDLEBuild.ps1" -BuildFolder "E:\Games\TestAcServer\Bin" -ServerFolder "E:\Games\AcServer"

# Grab latest Weenies
#& "$PSScriptRoot\Get-ACPLSDWeenie.ps1" -DownloadFolder "E:\Games\ACServer\Data\json\weenies" -WCID (1..99999)