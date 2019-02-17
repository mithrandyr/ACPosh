# ACPosh
PowerShell Scripts for GDLE
Simplify aspects of running GDLE...

## Tasks

### Simple Tools

- TeleTowns Get/Set/New Commands (take /myloc as input)
(arwic output: )

- processing float to hex
```
# Get the byte representation (produces D0, EB, FE, 46)
$bytes = [BitConverter]::GetBytes([single]32629.90625)
$bytes | Foreach-Object { ("{0:X2}" -f $_) }

# Convert the $bytes back to a float (produces 32629.91)
[BitConverter]::ToSingle($bytes, 0)
```


### Compile GDLE Project

- Find appropriate commandline arguments

### Setup Database

- Require SimplySql
- Call DB files in bin folder
- On new repo, deploy new DB and compare schemas to see if anything is changed

### Get-GDLELifeStoned

- Parse https://www.lifestoned.org/Weenie/Recent to grab latest weenies (as option)
- Parse https://www.lifestoned.org/WorldRelease to grab latest world release

### GDLEnhanced.exe commandline args

- -c "path to config"
- -s "for autostart"