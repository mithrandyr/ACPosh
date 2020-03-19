[CmdletBinding()]
param([string]$server = "localhost", [string]$database = "gdle", [string]$user = "root", [string]$pw = "root")

$cn = $PSCmdlet.MyInvocation.MyCommand.Name

Open-MySqlConnection -server $server -Database $database -UserName $user -Password $pw -WarningAction SilentlyContinue -ConnectionName $cn

$query = "SELECT a.id AS AccountId
, a.username AS AccountName
, CASE access WHEN 6 THEN 1 ELSE 0 END AS IsAdmin
, date_add('1970-1-1', INTERVAL a.date_created second) AS AccountCreated
, c.name AS CharacterName
, c.weenie_id AS CharacterID
, date_add('1970-1-1', INTERVAL c.date_created second) AS CharacterCreated
, date_add('1970-1-1', INTERVAL c.ts_login second) AS LastLogin
FROM accounts AS a
LEFT JOIN characters AS c
    ON a.id = c.account_id"

Invoke-SqlQuery -Query $query -Stream  -ConnectionName $cn
Close-SqlConnection -ConnectionName $cn