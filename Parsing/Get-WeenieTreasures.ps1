param([parameter(Mandatory)][string]$path)


$data = Get-Content -Path $path | ConvertFrom-Json

$treasureList = @{}

$id = 1
$bucket = @()
foreach($d in $data.createList) {
    if($d.wcid -eq 0) {
        $bucket += $d
        $treasureList["grp$id"] = $bucket
        $bucket = @()
        $id += 1
    }
    else { $bucket += $d }
}
if($bucket.count -gt 0) { $treasureList["grp$id"] = $bucket }

$treasureList