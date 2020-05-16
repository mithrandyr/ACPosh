param([parameter(Mandatory)][string]$path)


$data = Get-Content -Path $path | ConvertFrom-Json

$treasureList = @()

$bucket = @()
foreach($d in $data.createList) {
    if($d.wcid -eq 0) {
        $bucket += $d
        $treasureList += $bucket
        $bucket = @()
    }
    else { $bucket += $d }
}
if($bucket.count -gt 0) { $treasureList += $bucket }

$treasureList