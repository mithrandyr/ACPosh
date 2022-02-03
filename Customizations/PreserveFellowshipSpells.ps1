param([string]$PathToSpellsJson = "E:\Games\ACServer\Data\json\spells.json")

$ErrorActionPreference = "Stop"
$preservedFellowship = Get-Content -Raw -Path "$PSScriptRoot\preservedFellowship.json" | ConvertFrom-Json

$spells = Get-Content -Raw -Path $PathToSpellsJson | ConvertFrom-Json

$spellList = $spells.table.spellBaseHash | Where-Object key -NotIn $preservedFellowship.key
$spellList += $preservedFellowship
$spells.table.spellBaseHash = $spellList | Sort-Object key
$spells | ConvertTo-Json -Depth 15 -Compress | Set-Content -Path $PathToSpellsJson
