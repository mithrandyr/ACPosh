param(
    [Parameter(mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][Alias("FullName")][string[]]$path
    , [Parameter(mandatory, ValueFromPipelineByPropertyName)][ValidateSet("intStats","boolStats","didStats","floatStats","spellbook")][string]$Section
    , [Parameter(ValueFromPipelineByPropertyName)][string]$Key
)
process {
    foreach($p in $path){
        try {
            $n = (Split-Path $p -Leaf)
            $obj = Get-Content $p | ConvertFrom-Json
            [bool]$Update = $false
            
            if($obj.$Section) {
                if($Key) {
                    if($obj.$Section.where({$_.key -eq $Key})) {
                        $obj.$Section = $obj.$Section.where({$_.key -ne $Key})
                        $Update = $true
                    }
                    else { Write-Warning "$n does not have '$Section[$key]'" }
                }
                else { 
                    $obj.$Section = @()
                    $Update = $true
                }
            }
            else { Write-Warning "$n does not have '$Section'" }
            
            if($Update) { $obj | ConvertTo-Json -Depth 10 -Compress | Set-Content -Path $p }
        }
        catch {
            Write-Warning "Error on '$n'..."
            throw $_
        }
    }
}