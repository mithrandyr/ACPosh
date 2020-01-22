param([parameter(Mandatory)][string]$filePath, [switch]$AsString, [switch]$UseSort)

$weenie = Get-Content -Raw -Path $filePath | ConvertFrom-Json
$spells = Get-Content -Raw -Path "$PSScriptRoot\spellData.json" | ConvertFrom-Json

$results = $weenie.spellbook.key |
    ForEach-Object { 
        $id = $_
        $spells.where({$_.SpellId -eq $id})
    }
if($UseSort) { $results = $results | Sort-Object School, Category }

if($AsString) { $results | ForEach-Object { "{0} - {1} [{2} : {3}] ({4}) > {5}" -f $_.SpellId, $_.Name, $_.School, $_.SpellLevel, $_.Category, $_.Description } }
else { $results }