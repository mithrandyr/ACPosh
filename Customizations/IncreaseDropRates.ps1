param([parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][Alias("FullName")][string]$Path
    , [parameter()][hashtable]$ItemDropRates
    , [parameter(Mandatory)][string]$ChangedInfoDirectory
    , [switch]$noChange
)
begin {
    if($ItemDropRates.Count -eq 0) {
        $ItemDropRates = @{
            6353 = .1 #Pyreal Mote
            6355 = .1 #Pyreal SLiver
            6060 = .1 #Dark Speck
            6059 = .1 #Dark Sliver
            6058 = .1 #Dark Shard
            6055 = .1 #Cracked Shard
            6057 = .1 #Tiny Shard
            6056 = .1 #Small Shard
        }
    }
    if(-not(Test-Path -Path $ChangedInfoDirectory)) { New-Item -ItemType Directory -Path $ChangedInfoDirectory | Out-Null }
    $ErrorActionPreference = "stop"
}

process {
    try {
        $data = Get-Content -Path $path -Raw | ConvertFrom-Json
                
        if($data.weenieType -eq 10) {
            $changeData = [PSCustomObject]@{
                FileName = $Path
                WCID = $data.wcid
                Changes = @()
            }            
            
            $remainingRate = 1.0
            $madeChange = $false
            foreach($t in $data.createList) {
                $treasureWCID = $t.wcid
                if($treasureWCID -in $ItemDropRates.Keys) {
                    $newRate = $ItemDropRates.$treasureWCID #Get dropRate
                    if($newRate -gt $t.shade) { #see if droprate is greater than existing
                        $changeData.Changes += [PSCustomObject]@{
                            wcid = $t.wcid
                            OriginalRate = $t.shade
                            NewRate = $newRate
                        }
                        $t.shade = $newRate
                        $madeChange = $true
                        $remainingRate -= $newRate
                    }
                }
                elseif($t.wcid -eq 0) {
                    if($madeChange) {
                        $t.shade = $remainingRate
                        $madeChange = $false
                    }
                    $remainingRate = 1.0
                }
                else { $remainingRate -= $d.shade }
            }

            if($changeData.Changes.Count -gt 0) {
                $changeData |
                    ConvertTo-Json -Compress |
                    Set-Content -Path (Join-Path $ChangedInfoDirectory ("changed-{0}-{1:yyyyMMdd}.json" -f $changeData.wcid, (get-date)))
                
                if(-not $noChange){
                    $data |
                    ConvertTo-Json -Compress -Depth 10 | 
                    Set-Content -Path $Path
                }
                else {
                    $data |
                    ConvertTo-Json -Compress -Depth 10 | 
                    Set-Content -Path (join-Path $ChangedInfoDirectory (Split-Path $path -Leaf))
                }
            }            
        }
    }
    catch {
        Write-Warning "Could not process: $path"
        $_
    }
}