param([parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)][Alias("FullName")][string]$Path
    , [parameter()][hashtable]$ItemDropRates
    , [parameter()][string]$ChangedInfoDirectory = "E:\Games\trackChanges"
    , [switch]$noChange
)
begin {
    if($ItemDropRates.Count -eq 0) {
        $ItemDropRates = @{
            6353 = .1 #Pyreal Mote
            6355 = .1 #Pyreal Sliver
            6060 = .15 #Dark Speck
            6059 = .15 #Dark Sliver
            6058 = .15 #Dark Shard
            6055 = .3 #Cracked Shard
            6057 = .3 #Tiny Shard
            6056 = .3 #Small Shard
            12689 = .1 #Diamond Powder
            7338 = .2 #Diamond Heart
            23202 = .2 #Platinum Golem Heart
        }
    }
    if(-not(Test-Path -Path $ChangedInfoDirectory)) { New-Item -ItemType Directory -Path $ChangedInfoDirectory | Out-Null }
    $ErrorActionPreference = "stop"

    $FileList = [System.Collections.Generic.List[string]]::new()
    $fileCount = 0
}

process { 
    $FileList.Add($Path)
    $fileCount += 1
}
end {
    $fCount = $FileList.Count
    $fProcessed = 0
    foreach($file in $FileList) {
        $fProcessed += 1
        Write-Progress -Activity "IncreasedDropRate Change" -Status $file -PercentComplete ($fProcessed * 100 / $fCount)
        try {
            $data = Get-Content -Path $file -Raw | ConvertFrom-Json
                    
            if($data.weenieType -eq 10) {
                $changeData = [PSCustomObject]@{
                    FileName = $file
                    WCID = $data.wcid
                    Changes = @()
                }            
                
                $remainingRate = 1.0
                $madeChange = $false
                foreach($t in $data.createList) {
                    $treasureWCID = [int]$t.wcid
                    if($treasureWCID -in $ItemDropRates.Keys) {
                        $newRate = $ItemDropRates[$treasureWCID] #Get dropRate
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
                        Set-Content -Path $file
                    }
                    else {
                        $data |
                        ConvertTo-Json -Compress -Depth 10 | 
                        Set-Content -Path (join-Path $ChangedInfoDirectory (Split-Path $file -Leaf))
                    }
                }            
            }
        }
        catch {
            Write-Warning "Could not process: $file"
            $_
        }
    }
    Write-Progress -Activity "IncreasedDropRate Change" -Completed
}