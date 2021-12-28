param([string]$KeysToSend, [int]$keyDelay = 25, [int]$LoopCount = 0, [int]$LoopDelay = 50)

$w = Select-Window -Title "Asheron's Call"
$keysCount = $KeysToSend.Length

if($KeysToSend -and $LoopCount -gt 0) {
    Set-WindowActive $w
    Write-Host "Selected Asheron's Call!"

    Write-Host "Getting ready to send '$KeysToSend' $LoopCount times!"

    foreach ($loop in (1..$LoopCount)) {
        foreach($c in (1..$keysCount)) {
            Send-Keys -Keys $c -Window $w
            if ($c -lt $keysCount) { Start-Sleep -Milliseconds $keyDelay }
        }
        if($loop -lt $LoopCount) { Start-Sleep -Milliseconds $LoopDelay }
        Write-Host "." -NoNewline
    }
}