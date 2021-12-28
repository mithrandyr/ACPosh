Param([string]$FilePath = "E:\games\ACServer\Data\json\spells.json")
$spells = Get-Content -Path $FilePath -Raw | ConvertFrom-Json | ForEach-Object { $_.table.spellBaseHash }
$spells