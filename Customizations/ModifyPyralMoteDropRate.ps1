param([parameter()][string]$path = "E:\Games\ACServer\Data\json\weenies")

Filter GetIndex ([scriptblock]$sb) {
    $c += 1
    if($_ | Where-Object $sb) {
        return $c - 1
    }
}

$levelChance = @{
    8 = 0.02
   15 = 0.05
   20 = 0.05
   30 = 0.05
   40 = 0.05
   50 = 0.10
   60 = 0.10
   80 = 0.10
  100 = 0.15
  115 = 0.15
  135 = 0.15
  160 = 0.20
  185 = 0.20
  200 = 0.20
  220 = 0.20
}

$files = "11528 - Elaniwood Golem.json","11531 - Sand Golem.json","11994 - Basalt Golem.json","14520 - Pyreal Golem.json","14521 - Glacial Golem.json","14522 - Unstable Glacial Golem.json","14559 - Oak Golem.json","14800 - Crystal Golem.json","15266 - Acidic Coral Golem.json","15267 - Acidic Diamond Golem.json","16909 - Granite Golem.json","16910 - Obsidian Golem.json","194 - Copper Golem.json","195 - Granite Golem.json","19542 - Crystal Golem Imperator.json","19543 - Diamond Golem Suzerain.json","196 - Ice Golem.json","197 - Iron Golem.json","198 - Limestone Golem.json","199 - Magma Golem.json","200 - Mud Golem.json","201 - Obsidian Golem.json","202 - Sandstone Golem.json","22003 - Glacial Golem Margrave.json","22933 - Mist Golem.json","23035 - Obsidian Excavation Golem.json","23082 - Nubilous Golem.json","23345 - Iron Golem Guardian.json","24478 - Small Coral Golem.json","24479 - Small Granite Golem.json","24480 - Small Iron Golem.json","24481 - Small Magma Golem.json","24482 - Small Mud Golem.json","24483 - Small Obsidian Golem.json","24484 - Small Sandstone Golem.json","24485 - Small Water Golem.json","24486 - Small Wood Golem.json","24517 - Small Sand Golem.json","26008 - Gelidite Golem.json","26468 - Mighty Oak Golem.json","27254 - Copper Golem Kingpin.json","27255 - Mud Golem Sludge Lord.json","27564 - Coral Golem Viceroy.json","27565 - Glacial Golem Margrave.json","27566 - Magma Golem Exarch.json","27709 - Great Elariwood Golem.json","27798 - Ancient Diamond Golem.json","28049 - Ancient Coral Golem.json","28050 - Ancient Coral Golem.json","28051 - Ancient Coral Golem.json","28247 - Sapphire Golem.json","29356 - Damaged Glacial Golem.json","29357 - Fractured Glacial Golem.json","30440 - Water Golem.json","31340 - Guardian Blue Coral Golem.json","31919 - Wave Golem.json","31920 - Aqueous Golem.json","4216 - Diamond Golem.json","6645 - Magma Golem.json","7096 - Gold Golem.json","7097 - Platinum Golem.json","7098 - Plasma Golem.json","7099 - Vapor Golem.json","7421 - Diamond Golem.json","7507 - Coral Golem.json","7626 - Coral Golem.json","9057 - Zirconium Golem.json","941 - Water Golem.json","942 - Wood Golem.json"

Get-ChildItem -Path $path -Filter *.json |
    Where-Object {$_.name -in $files } |
    ForEach-Object {
        $data = Get-Content -Path $_.FullName | ConvertFrom-Json

        $ind = $data.createList | GetIndex {$_.wcid -eq 6353}
        $chance = $levelChance[$data.intStats.where({$_.key -eq 25})[0].Value]

        if($ind -ge 0) {
            $data.createList[$ind].shade = $chance
            $data.createList[$ind+1].shade = (1-$chance)
        }
        else {
            if(-not $data.createlist) { 
                $data | Add-Member -NotePropertyName createlist -NotePropertyValue @()
            }

            $data.createList += [PSCustomObject]@{
                wcid = 6353
                palette = 0
                shade = $chance
                destination = 9
                stack_size  = 0
                try_to_bond = 0
            }
            
            $data.createList += [PSCustomObject]@{
                wcid = 0
                palette = 0
                shade = 1 - $chance
                destination = 9
                stack_size  = 0
                try_to_bond = 0
            }
        }
        
        Set-Content -Path $_.FullName -Value ($data | ConvertTo-Json -Depth 10 -Compress)
        Write-Host "$($_.basename) - modified!"
    }

