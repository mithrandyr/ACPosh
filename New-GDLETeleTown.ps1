param(
    [Parameter()][string]$server = "localhost"
    , [Parameter()][string]$database = "gdle"
    , [Parameter()][string]$u = "root"
    , [Parameter()][string]$p = "root"
    , [Parameter(Mandatory)][string]$Description
    , [Parameter(Mandatory)][string]$Command
    , [Parameter(Mandatory)][hashtable]$Values
)

Open-MySqlConnection -Server $server -Database $database -UserName $u -Password $p

if((Invoke-SqlScalar -Query "SELECT COUNT(*) FROM teletowns WHERE Command = @cmd" -Parameters @{cmd = $Command}) -eq 0) {
    $query = "INSERT INTO teletowns (Description, Command, Landblock, Position_X, Position_Y, Position_Z, Orientation_W, Orientation_X, Orientation_Y, Orientation_Z) VALUES (@description, @command, @Landblock, @Position_X, @Position_Y, @Position_Z, @Orientation_W, @Orientation_X, @Orientation_Y, @Orientation_Z)"
    $values["Description"] = $Description
    $values["Command"] = $Command
    Invoke-SqlUpdate -Query $query -Parameters $Values
}
else { Write-Warning "Command already exists!" }

Close-SqlConnection