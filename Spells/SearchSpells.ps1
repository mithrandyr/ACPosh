[cmdletBinding(DefaultParameterSetName="search")]
param([Parameter(ParameterSetName="search")][string]$Name
    , [Parameter(ParameterSetName="search")][string]$Description
    , [Parameter(ParameterSetName="search")][string[]][ValidateSet("Life Magic","Item Enchantment","Creature Enchantment","War Magic","Void Magic")]$School
    , [Parameter(ParameterSetName="search")][int[]][ValidateSet(1,2,3,4,5,6,7,8)]$SpellLevel
    , [Parameter(ParameterSetName="search")][string[]][ValidateSet("Boost","Dispel","Enchantment","Enchantment Projectile","Fellow Boost","Fellow Dispel","Fellow Enchantment","Fellow PortalSending","Life Projectile","Portal Link","Portal Recall","Portal Sending","Portal Summon","Projectile","Transfer")]$SpellType
    , [Parameter(ParameterSetName="search")][string[]][ValidateSet("Resistable","PKSensitive","Beneficial", "TargetSelf","TargetOther","Reversed","NotIndoor","NotResearchable","FastCast")]$Flags
    , [Parameter(ParameterSetName="search")][string]$Category
    , [Parameter(Mandatory,ParameterSetName="id")][int]$Id
    , [switch]$ForClipboard
    , [string]$filePath = "$PSScriptRoot\spellData.json"
)

$spells = Get-Content $filePath -Raw | ConvertFrom-Json

if($Id) {
    $spells = $spells.where({$_.SpellId -eq $Id})
}
else {
    $filterArray = @()
    if($Name) { $filterArray += {$_.Name -like "*$name*"} }
    if($Description) { $filterArray += {$_.Description -like "*$Description*"} }
    if($School) { $filterArray += {$_.School -in $School} }
    if($SpellLevel) { $filterArray += {$_.SpellLevel -in $SpellLevel} }
    if($SpellType) { $filterArray += {$_.SpellType -in $SpellType} }
    if($Category) { $filterArray += {$_.Category -like "*$Category*"} }
    if($Flags) { $filterArray += {
        $r = $false
        foreach($f in $Flags) {
            if($_.Flags -contains $f) { $r = $f -and $true }
            else {
                $r = $false
                break
            }
        }
        $r
    } }
    
    foreach($f in $filterArray) {
        $spells = $spells | Where-Object $f
    }
    
    $spells = $spells | Sort-Object School, @{Expression = "SpellLevel"; Descending= $True}, Category, Name
}

if($ForClipboard) {
    $spells |
        Out-GridView -Title "Select the Spells you want..." -OutputMode Multiple |
        ForEach-Object { ', { "key": ' + $_.SpellId.ToString() + ', "value": { "casting_likelihood": 2.0 } }' } |
        Set-Clipboard
}
else { $spells }