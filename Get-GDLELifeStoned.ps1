Param([string]$downloadPath, [ValidateRange(10,50)][int]$BatchSize = 50, [int]$ThrottleLimit = $env:NUMBER_OF_PROCESSORS)

if(-not (Test-Path $downloadPath -PathType Container)) {
    throw "Directory not found! ($downloadPath)"
}

$groups = [math]::Ceiling(80000 / $BatchSize)
$cmd = "$PSScriptRoot\Get-ACPLSDWeenie.ps1"
(1..$groups).foreach({
    $e = $_ * $BatchSize
    $s = $e - $BatchSize + 1
    [scriptblock]$sb = { param($s, $e, $cmd, $dl)
        $s..$e | &$cmd -DownloadFolder $dl -Silent
    }

    Start-ThreadJob -Name "LifeStoneBatch-$_" -ScriptBlock $sb -ArgumentList @($s, $e, $cmd, $downloadPath) -ThrottleLimit $ThrottleLimit | Out-Null
})