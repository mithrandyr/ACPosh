param([parameter()][string]$MsbuildFile = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars64.bat"
    , [string]$workingDir = (Get-Location))

$psi = [System.Diagnostics.ProcessStartInfo]::new()
$psi.FileName = "cmd.exe"
$psi.UseShellExecute = $false
$psi.RedirectStandardInput = $true
#$psi.RedirectStandardOutput = $true
$psi.WorkingDirectory = $workingDir

Write-Host ("=" * 45), "STARTING THE BUILD", ("=" * 45)
$p = [System.Diagnostics.Process]::Start($psi)
Start-Sleep -Milliseconds 250
$p.StandardInput.Writeline('call "{0}"' -f $MsbuildFile)
$p.StandardInput.Writeline("msbuild -t:rebuild /property:Configuration=Release")
$p.StandardInput.Writeline("exit")
$p.WaitForExit()
$p.dispose()
Write-Host ("=" * 45), "DONE WITH BUILD", ("=" * 45)