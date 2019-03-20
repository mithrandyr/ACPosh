param(
    [Parameter(mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][Alias("FullName")][string[]]$path
    , [Parameter(mandatory, ValueFromPipelineByPropertyName)][ValidateSet("intStats","boolStats","didStats","floatStats","spellbook")][string]$Section
    , [Parameter(ValueFromPipelineByPropertyName)][string]$Key
    , [Parameter(mandatory, ValueFromPipelineByPropertyName)]$Value
    , [switch]$Force
)
process {
    foreach($p in $path){
        try {
            $n = (Split-Path $p -Leaf)
            $obj = Get-Content $p | ConvertFrom-Json
            [bool]$Update = $false
            
            if(-not $obj.$Section) {
                if(-not $Key) { $obj.$Section = $Value }
                else { $obj | Add-Member -NotePropertyName $Section -NotePropertyValue @([PSCustomObject]@{key=$Key; value=$Value}) }
                $Update = $true
            }
            else {
                if($Key) {
                    if($obj.$Section.where({$_.key -eq $Key})){
                        if($Force) {
                            $obj.$Section.where({$_.Key -eq $Key})[0] = $Value
                            $Update = $true
                        }
                        else {
                            $v = $obj.$Section.where({$_.Key -eq $Key})[0].Value
                            Write-Warning "$n already has '$Section[$Key]' of '$v'"
                        }
                    }
                    else {
                        $obj.$Section += [PSCustomObject]@{key = $Key; value = $Value}
                        $Update = $true
                    }
                }
                else {
                    if($Force) {
                        $obj.$Section = $value
                        $Update = $true
                    }
                    else { Write-Warning "$n already has '$Section' populated" }
                }
            }

            if($Update) { $obj | ConvertTo-Json -Depth 10 -Compress | Set-Content -Path $p }
        }
        catch {
            Write-Warning "Error on '$n'..."
            throw $_
        }
    }
}