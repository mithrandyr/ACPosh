param(
    [Parameter(mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][Alias("FullName")][string[]]$path
    , [ValidateSet("All","intStats","boolStats","didStats","floatStats","spellbook")][string]$Section = "All"
)
process {
    foreach($p in $path){
        if($Section -eq "all") {
            Get-Content $p |
                ConvertFrom-Json |
                Add-Member -NotePropertyName "Description" -NotePropertyValue (Split-Path $p -Leaf) -PassThru
        }
        else {
            Get-Content $p |
                ConvertFrom-Json |
                Select-Object -ExpandProperty $Section |
                Add-Member -NotePropertyName "Description" -NotePropertyValue (Split-Path $p -Leaf) -PassThru
        }
    }
}