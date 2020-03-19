[CmdletBinding()]
param([parameter(Mandatory, ValueFromPipelineByPropertyName)][int]$AccountId
    , [string]$server = "localhost", [string]$database = "gdle", [string]$user = "root", [string]$pw = "root")
begin {
    $cn = $PSCmdlet.MyInvocation.MyCommand.Name

    Open-MySqlConnection -server $server -Database $database -UserName $user -Password $pw -WarningAction SilentlyContinue -ConnectionName $cn
}
process {
    try {
        Start-SqlTransaction -ConnectionName $cn

        Write-Host "Account..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM accounts WHERE id = @id" -Parameters @{id = $AccountId} -ConnectionName $cn
        Complete-SqlTransaction -ConnectionName $cn
    }
    catch {
        Write-Host "Error: $_"
        Undo-SqlTransaction -ConnectionName $cn
    }
}
end { Close-SqlConnection -ConnectionName $cn }