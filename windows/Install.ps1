param([string]$GameFolder)
$ErrorActionPreference='Stop'
try {
    if($env:HD_WINDOWS_CHOICE -notmatch '^(?:[1-9]|10)$'){throw 'Invalid choice / 无效选项'}
    $languages=@('zh','en','pt','ru','es','de','ja','fr','ko','tr')
    $language=$languages[[int]$env:HD_WINDOWS_CHOICE-1]
    if(!$GameFolder){
        Add-Type -AssemblyName System.Windows.Forms
        $picker=New-Object System.Windows.Forms.FolderBrowserDialog
        $picker.Description='Select your Hole Dweller folder / 选择自己的游戏目录（HoleDweller.exe + data.win）'
        $picker.ShowNewFolderButton=$false
        if($picker.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK){exit 0}
        $GameFolder=$picker.SelectedPath
    }
    $mode=if($language -eq 'en'){'restore'}else{'install'}
    if($language -eq 'en'){$language='zh'}
    & (Join-Path $PSScriptRoot 'WindowsPatch.exe') $mode $GameFolder $language
    exit $LASTEXITCODE
}catch{Write-Host $_.Exception.Message;exit 1}
