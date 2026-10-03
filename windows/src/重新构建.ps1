param([Parameter(Mandatory=$true)][string]$GameData,[Parameter(Mandatory=$true)][string]$ToolPath,[ValidateSet('pt','ru','es','de','ja','fr','ko','tr')][string]$Language='pt',[string]$Python='python')
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$shared=Join-Path (Split-Path $root -Parent) 'android'
if((Get-FileHash -LiteralPath $GameData -Algorithm SHA256).Hash.ToLower() -ne '5123c1404fa33996b6d07673584b0bd0c8bd81a173d88abe380e3a49785ce68b'){throw 'Unsupported original game resources'}
$cfg=Get-Content -LiteralPath (Join-Path $shared 'locales/languages.json') -Raw -Encoding UTF8 | ConvertFrom-Json
& $Python (Join-Path $shared 'src/检查语言.py') $Language
if($LASTEXITCODE -ne 0){throw 'Translation validation failed'}
$env:HD_WINDOWS_PROJECT=$shared;$env:HD_WINDOWS_LANGUAGE=$Language;$env:HD_WINDOWS_FONT=$cfg.$Language.font
$build=Join-Path $root '.build';New-Item -ItemType Directory -Force -Path $build | Out-Null
$translated=Join-Path $build ($Language+'.win')
$log=& $ToolPath load $GameData -s (Join-Path $PSScriptRoot '本地化.csx') -o $translated -f 2>&1
$log | Set-Content -LiteralPath (Join-Path $build ($Language+'.log')) -Encoding UTF8
if($LASTEXITCODE -ne 0 -or ($log -join "`n") -match 'Script execution failed|Code import unsuccessful|Exception' -or !(Test-Path -LiteralPath $translated)){throw 'Localization compilation failed; inspect .build log'}
& $Python (Join-Path $PSScriptRoot '生成差分.py') $GameData $translated (Join-Path $root ('patch/'+$Language+'.hdp'))
if($LASTEXITCODE -ne 0){throw 'Patch generation failed'}
Write-Host 'Rebuilt patch. Update version hashes and test install/restore before release.'
