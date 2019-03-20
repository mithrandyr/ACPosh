param(
    [Parameter(mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][Alias("FullName")][string[]]$path
    , [ValidateSet("All","intStats","boolStats","didStats","floatStats","spellbook")][string]$view = "All"
)
process {
    foreach($p in $path){
        if($view -eq "all") {
            Get-Content $p |
                ConvertFrom-Json |
                Add-Member -NotePropertyName "Description" -NotePropertyValue (Split-Path $p -Leaf) -PassThru
        }
        else {
            Get-Content $p |
                ConvertFrom-Json |
                Select-Object -ExpandProperty $view |
                Add-Member -NotePropertyName "Description" -NotePropertyValue (Split-Path $p -Leaf) -PassThru
        }
    }
}