param([string]$GameFolder)
$ErrorActionPreference='Stop'
$root=$PSScriptRoot
try {
    if (!$GameFolder) {
        Add-Type -AssemblyName System.Windows.Forms
        $dialog=New-Object System.Windows.Forms.FolderBrowserDialog
        $dialog.Description='请选择你自己的 Hole Dweller 游戏目录（包含 data.win）。'
        $dialog.SelectedPath='C:\Program Files (x86)\Steam\steamapps\common\Hole Dweller'
        if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) { exit }
        $GameFolder=$dialog.SelectedPath
    }
    & (Join-Path $root 'tools\python\python.exe') -X utf8 (Join-Path $root 'src\打包.py') $GameFolder
    if ($LASTEXITCODE -ne 0) { throw '构建没有完成，请查看上面的错误。' }
    Write-Host '把 output 文件夹中的 APK 复制到手机安装即可。'
}
catch { Write-Host $_.Exception.Message -ForegroundColor Red; exit 1 }
