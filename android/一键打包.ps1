param([string]$GameFolder,[ValidateSet('zh','en')][string]$Language='zh')
& (Join-Path $PSScriptRoot 'Build-APK.ps1') -GameFolder $GameFolder -Language $Language
exit $LASTEXITCODE
