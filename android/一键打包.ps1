param([string]$GameFolder,[ValidateSet('zh','en','pt','ru','es','de','ja','fr','ko','tr')][string]$Language='zh')
& (Join-Path $PSScriptRoot 'Build-APK.ps1') -GameFolder $GameFolder -Language $Language
exit $LASTEXITCODE
