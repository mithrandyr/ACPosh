# Fun tools for working with the Spell section of a Weenie

## Relevant PowerShell Scripts

### SearchSpells.ps1
- This uses the following json file "spellData.json" -- which was created from parsing the GDLE spells.json and ac.yotesfan.com spell database.
- Various options, basically allows you to search for spells based upon common ideas (school, level, flags, name, etc)
- If you use the -ForClipboard parameter will send results to Out-GridView, allowing you to select the results you want.. resultes as then copied to clipboard in a json format perfect for adding to weenie

### ParseWeenieSpells.ps1
- This uses the following json file "spellData.json" -- which was created from parsing the GDLE spells.json and ac.yotesfan.com spell database.
- Pass in a weenie file, will return the spells on the weenie, use the -AsString to get a simply text representation!

## Miscellaneous
- ExtractSpells.ps1 > use this to generate the spellData.json (pulls from GDLE spells.json).
- QuerySpells.ps1 > use this to generate the spellAdditional.json (pulls from ac.yotesfan.com)