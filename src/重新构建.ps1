param(
    [Parameter(Mandatory=$true)][string]$GameData,
    [Parameter(Mandatory=$true)][string]$ToolPath,
    [string]$Python='python'
)
$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$info=Get-Content -LiteralPath (Join-Path $projectRoot '版本信息.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$original=(Resolve-Path -LiteralPath $GameData).Path
if ((Get-FileHash -LiteralPath $original -Algorithm SHA256).Hash.ToLowerInvariant() -ne $info.'原版SHA256') {
    throw '原版校验不匹配。请先完成新版本文本适配，不能只改校验值强行构建。'
}
$build=Join-Path $projectRoot '.build'
New-Item -ItemType Directory -Force $build | Out-Null
$translated=Join-Path $build 'zhCN.win'
$oldProjectEnv=$env:HD_ZHCN_PROJECT
try {
    $env:HD_ZHCN_PROJECT=$projectRoot
    $buildLog=& $ToolPath load $original -s (Join-Path $PSScriptRoot '汉化.csx') -o $translated -f 2>&1
    $buildLog | Set-Content -LiteralPath (Join-Path $build '构建日志.txt') -Encoding UTF8
    if (($buildLog -join "`n") -match 'Exception|Code import unsuccessful|Script execution failed' -or -not (Test-Path -LiteralPath $translated)) {
        throw '构建失败，请查看 .build 中的构建日志。'
    }
    & $Python (Join-Path $PSScriptRoot '生成差分.py') $original $translated $projectRoot
    if ($LASTEXITCODE -ne 0) { throw '差分生成失败。请确认已安装 bsdiff4。' }
    $compiler=Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
    & $compiler /nologo /optimize+ /target:exe "/out:$(Join-Path $projectRoot '汉化安装器.exe')" /reference:System.Windows.Forms.dll (Join-Path $PSScriptRoot '安装器.cs')
    if ($LASTEXITCODE -ne 0) { throw '安装器编译失败。' }
    Write-Host '构建完成。请在独立测试目录验证游戏、安装、还原及版本拒绝，再更新 README 和发布包。'
}
finally { $env:HD_ZHCN_PROJECT=$oldProjectEnv }
