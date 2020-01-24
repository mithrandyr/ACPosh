function ConvertFrom-Weenie {
    [cmdletbinding(DefaultParameterSetName="data")]
    param([parameter(Mandatory,ValueFromPipeline, ParameterSetName="data")][string[]]$Text
        , [parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName, ParameterSetName="path")][string]$Path)

    process {
        if ($Path) { $Text = Get-Content -Raw -Path $Path }
        $text = $Text -join [System.Environment]::NewLine

        [weenie]::new($text)
    }
}
