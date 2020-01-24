#using module .\enums.psm1
using module .\class.psm1

. "$PSScriptRoot\ConvertFrom-Weenie.ps1"
. "$PSScriptRoot\ConvertTo-Weenie.ps1"

Export-ModuleMember -Function ConvertFrom-Weenie, ConvertTo-Weenie