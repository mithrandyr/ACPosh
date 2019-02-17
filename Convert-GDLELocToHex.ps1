param(
    [parameter(Mandatory, ParameterSetName="string")][string]$LocOutput
    #, [parameter(Mandatory, ParameterSetName="parm")][string]$Landbloc
)

$list = $LocOutput -split " "
if($list[0].StartsWith("0x")) { $list[0] = $list[0].SubString(2) }
[scriptblock]$ToHex = {
    param([string]$val)
    $bytes = [System.BitConverter]::GetBytes([single]$val)
    [array]::Reverse($bytes)
    $result = ($bytes | ForEach-Object { "{0:X2}" -f $_ }) -join ""
    Write-Output $result
}

[scriptblock]$FromHex = {
    param([string]$val)

}

$result = [Ordered]@{
    Landblock = $list[0]
    Position_X = &$ToHex -val $list[1].TrimStart("[")
    Position_Y = &$ToHex -val $list[2]
    Position_Z = &$ToHex -val $list[3].TrimEnd("]")
    Orientation_W = &$ToHex -val $list[4]
    Orientation_X = &$ToHex -val $list[5]
    Orientation_Y = &$ToHex -val $list[6]
    Orientation_Z = &$ToHex -val $list[7]
}

$result