param([string]$filePath = "$PSScriptRoot\spellData.json")

$spells = Get-Content $filePath -Raw | ConvertFrom-Json

