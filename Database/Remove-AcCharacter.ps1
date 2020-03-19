[CmdletBinding()]
param([parameter(Mandatory,ValueFromPipelineByPropertyName)][int]$CharacterId
    , [string]$server = "localhost", [string]$database = "gdle", [string]$user = "root", [string]$pw = "root")

    begin {
    $cn = $PSCmdlet.MyInvocation.MyCommand.Name
    Open-MySqlConnection -server $server -Database $database -UserName $user -Password $pw -WarningAction SilentlyContinue -ConnectionName $cn
}
process {
    try {
        Start-SqlTransaction -ConnectionName $cn
    
        Write-Host "WindowData..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM character_windowdata WHERE character_id = @id" -Parameters @{id = $CharacterId} -ConnectionName $cn
    
        Write-Host "Titles..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM character_titles WHERE character_id = @id" -Parameters @{id = $CharacterId} -ConnectionName $cn
    
        Write-Host "Squelch..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM character_squelch WHERE character_id = @id" -Parameters @{id = $CharacterId} -ConnectionName $cn
    
        Write-Host "Friends..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM character_friends WHERE character_id = @id" -Parameters @{id = $CharacterId} -ConnectionName $cn
    
        Write-Host "Corpses..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM character_corpses WHERE character_id = @id" -Parameters @{id = $CharacterId} -ConnectionName $cn
    
        Write-Host "Weenies..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM weenies WHERE top_level_object_id = @id" -Parameters @{id = $CharacterId} -ConnectionName $cn
    
        Write-Host "Character..." -NoNewline
        Invoke-SqlUpdate -Query "DELETE FROM characters WHERE weenie_id = @id" -Parameters @{id = $CharacterId} -ConnectionName $cn
        Complete-SqlTransaction -ConnectionName $cn
    }
    catch {
        Write-Host "Error: $_"
        Undo-SqlTransaction -ConnectionName $cn
    }
}
end { Close-SqlConnection -ConnectionName $cn }