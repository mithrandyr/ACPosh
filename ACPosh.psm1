New-Alias -Name gw -Value "$PSSCriptRoot\Get-Weenie.ps1"
New-Alias -Name sw -Value "$PSSCriptRoot\Set-Weenie.ps1"
New-Alias -Name rwp -Value "$PSSCriptRoot\Remove-WeenieProperty.ps1"

Export-ModuleMember -Alias gw, sw, rwp