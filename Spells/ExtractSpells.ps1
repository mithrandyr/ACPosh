Param([string]$FilePath = "E:\games\ACServer\Data\json\spells.json", [string]$OutputPath)
if(-not $OutputPath) { $OutputPath = "$PSScriptRoot\spellData.json" }
Write-Host "Reading spells ($filepath)..." -NoNewline
$spells = Get-Content -Path $FilePath -Raw | ConvertFrom-Json | ForEach-Object { $_.table.spellBaseHash }
Write-Host "Done!"

Write-Host "Reading SpellAdditional" -NoNewline
$spellAdditionals = Get-Content -Raw "$PSScriptRoot\spellAdditional.json" | ConvertFrom-Json
Write-Host "Done!"


$spellList = [System.Collections.ArrayList]::new()
#$c = 0; $max = $spells.count

Write-Host "Processing data..." -NoNewline

[scriptblock]$sb = {
    param($spells, $spellAdditionals)
    foreach($spell in $spells) {
        #$c +=1 
        #if($c % 10 -eq 0) { Write-Progress -Activity "Extracting Spells" -Status "$c out of $max" -CurrentOperation $spellAdditional.name -PercentComplete ($c * 100 / $max) }

        $spellAdditional = $spellAdditionals.where({$_.SpellId -eq $spell.key})[0]
        
        $spellInfo = [PSCustomObject]@{
            SpellId = $spell.key
            Name = $spell.value.Name
            Description = $spell.value.desc
            School = $spellAdditional.School
            SpellLevel = [int]$spellAdditional.SpellLevel
            SpellType = $spellAdditional.MetaSpellType
            SpellWords = $spellAdditional.SpellWords
            Category = $spellAdditional.SpellCategory
            ManaCost = $spell.value.base_mana
            Flags = @()        
            Details = $null
        }

        switch([int]$spell.value.bitfield) {
            {($_ -band 1) -eq 1} { $spellInfo.Flags += "Resistable" }
            {($_ -band 2) -eq 2} { $spellInfo.Flags += "PKSensitive" }
            {($_ -band 4) -eq 4} { $spellInfo.Flags += "Beneficial" }
            {($_ -band 8) -eq 8} { $spellInfo.Flags += "TargetSelf" }
            {($_ -band 8) -ne 8} { $spellInfo.Flags += "TargetOther" }
            {($_ -band 16) -eq 16} { $spellInfo.Flags += "Reversed" }
            {($_ -band 32) -eq 32} { $spellInfo.Flags += "NotIndoor" }
            {($_ -band 128) -eq 128} { $spellInfo.Flags += "NotResearchable" }
            {($_ -band 16384) -eq 16384} { $spellInfo.Flags += "FastCast" }
        }

        switch ($spellAdditional.MetaSpellType) {
            "Enchantment" {
                try{
                    $spellInfo.Details = [PSCustomObject]@{
                        MinValue = $spell.value.meta_spell.spell.smod.val
                        MaxValue = $spell.value.meta_spell.spell.smod.val
                        StatMod = if($spellAdditional.StatModKey.contains("(")) { $spellAdditional.StatModkey.SubString(0, $spellAdditional.StatModKey.IndexOf("(")-1) } else { $spellAdditional.StatModKey }
                        Duration = $spellAdditional.Duration
                    }
                    if($spellInfo.Details.StatMod -eq "Unhandled StatModType") { $spellInfo.Details.StatMod = "NaturalArmor" }
                }
                catch { $spellInfo.Details = $spell.value.meta_spell.spell }
            }
            "Projectile" {
                $spellInfo.Details = [PSCustomObject]@{
                    MinValue = $spell.value.meta_spell.spell.baseIntensity
                    MaxValue = $spell.value.meta_spell.spell.baseIntensity + $spell.value.meta_spell.spell.variance
                    DamageType = switch($spell.value.meta_spell.spell.etype) { 1 {"Slash"} 2 {"Pierce"} 4 {"Bludgeon"} 8 {"Cold"} 16 {"Fire"} 32 {"Acid"} 64 {"Electric"} 1024 {"Nether"} default {"?"}}
                }
            }
            "Boost" {
                $spellInfo.Details = [PSCustomObject]@{
                    MinValue = $spell.value.meta_spell.spell.boost
                    MaxValue = $spell.value.meta_spell.spell.boost + $spell.value.meta_spell.spell.boostVariance
                    BoostTarget = switch($spell.value.meta_spell.spell.dt) { 128 {"Health"} 256 {"Stamina"} 512 {"Mana"} Default {"?"}}
                }
            }
            "Transfer" {
                $spellInfo.Details = [PSCustomObject]@{
                    Drain = $spell.value.meta_spell.spell.proportion
                    DrainTarget = switch($spell.value.meta_spell.spell.src) { 2 {"Health"} 4 {"Stamina"} 6 {"Mana"} default {"?"}}
                    Grant = 1 - [math]::round($spell.value.meta_spell.spell.lossPercent, 2)
                    GrantTarget = switch($spell.value.meta_spell.spell.dest) { 2 {"Health"} 4 {"Stamina"} 6 {"Mana"} default {"?"}}
                    MaxValue = $spell.value.meta_spell.spell.transferCap
                }
            }
            "Dispel" {
                $spellInfo.Details = [PSCustomObject]@{
                    School = switch($spell.value.meta_spell.spell.school) { 0 {"All"} 2 {"Life"} 3 {"Item"} 4 {"Creature"} default {"?"}}
                }
            }
            default {
                $spellInfo.Details = $spell.value.meta_spell.spell
            }
        }
        $spellInfo
    }
}

$limit = 4
$grp = [math]::Ceiling($spells.count / $limit)
0..($limit-1) |
    ForEach-Object {
        $s = $grp  * $_
        $e = $grp * ($_ + 1) - 1
        Start-ThreadJob -ScriptBlock $sb -ArgumentList $spells[$s..$e], $spellAdditionals -ThrottleLimit $limit
    } |
    Wait-Job |
    ForEach-Object {
        $spellList.AddRange((Receive-Job $_)) | Out-Null
        Remove-Job -Job $_
    }

Write-Host "Done!"

$spellList | ConvertTo-Json -Depth 10 | Set-Content -Path $OutputPath -Force