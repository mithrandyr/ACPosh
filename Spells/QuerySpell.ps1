param([Parameter(Mandatory,ValueFromPipeline, ValueFromPipelineByPropertyName)][int]$spellid)
process {
    $url = "http://ac.yotesfan.com/spells/spell/{0}" -f $spellid
    $pattern = '[\w ]+(:|=>) [\w ()]*'
    [string[]]$nameList = @("MetaSpellType","StatModKey","SpellWords","Duration","School","SpellLevel","Name")

    $resultHash = [ordered]@{SpellId = $spellid}
    $data = (Invoke-RestMethod -Uri $url)
    $data |
        Select-String -Pattern $pattern -AllMatches |
        ForEach-Object { $_.matches.value } |
        ForEach-Object {
            $n, $v, $null = $_.Trim().Replace(" => ", ":").Replace(": ",":") -split ":"
            $n = $n -replace " "
            if($v -and $n -in $nameList -and -not $resultHash.Contains($n)) {
                $resultHash[$n] = $v.Trim()
            }        
        }

    $resultHash["SpellCategory"] = $data |
        Select-String -Pattern "Other Spells in this Category \((?'cat'[\w]+)\)" |
        Select-Object -ExpandProperty matches -first 1 |
        Select-Object -ExpandProperty groups |
        Where-Object name -eq "cat" |
        Select-Object -ExpandProperty Value

    [PSCustomObject]$resultHash
}