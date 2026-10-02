param([string]$Serial)
$ErrorActionPreference = 'Stop'
$adb = Join-Path $PSScriptRoot 'tools\adb\adb.exe'
$package = 'io.github.qianliexian.holedweller.zhcn'
Write-Host '无需 root。请用数据线连接安卓设备，开启 USB 调试，并在设备上允许本电脑调试。'
Write-Host '日志仅保存在电脑，不会自动上传。此工具不卸载游戏、不清除存档。'
$lines = & $adb devices
$devices = @($lines | Where-Object { $_ -match '^([^\s]+)\s+device$' } | ForEach-Object { ($_ -split '\s+')[0] } | Where-Object { $_ -notlike 'emulator-*' })
if ($Serial) {
    if ($devices -notcontains $Serial) { throw '指定的实体设备未连接或未授权。' }
} elseif ($devices.Count -eq 1) { $Serial = $devices[0] }
elseif ($devices.Count -eq 0) { throw '没有找到已授权的实体设备。请检查数据线、USB 调试授权；部分设备需要厂商 USB 驱动。' }
else {
    for ($i=0; $i -lt $devices.Count; $i++) { Write-Host "$($i+1). $($devices[$i])" }
    $choice = [int](Read-Host '输入设备序号')
    if ($choice -lt 1 -or $choice -gt $devices.Count) { throw '序号无效。' }
    $Serial = $devices[$choice-1]
}
$installed = & $adb -s $Serial shell pm path $package
if ($LASTEXITCODE -ne 0 -or -not ($installed -match 'package:')) { throw '设备尚未安装本项目 APK。' }
$folder = Join-Path $PSScriptRoot ('.local\设备日志\' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $folder -Force | Out-Null
$info = @('Hole Dweller 安卓日志', '打包器版本：0.2.0-alpha.3', '型号：' + (& $adb -s $Serial shell getprop ro.product.model), '安卓版本：' + (& $adb -s $Serial shell getprop ro.build.version.release), '架构：' + (& $adb -s $Serial shell getprop ro.product.cpu.abilist))
$info | Set-Content -LiteralPath (Join-Path $folder '设备信息.txt') -Encoding UTF8
$deviceTime = (& $adb -s $Serial shell "date '+%m-%d %H:%M:%S.000'").Trim()
& $adb -s $Serial shell am force-stop $package | Out-Null
& $adb -s $Serial shell am start -W -n "$package/com.company.game.RunnerActivity" | Set-Content -LiteralPath (Join-Path $folder '启动结果.txt') -Encoding UTF8
Write-Host '已启动游戏，正在收集 20 秒日志。若能进入，请操作到出问题的位置。'
Start-Sleep -Seconds 20
& $adb -s $Serial logcat -d -T $deviceTime -s yoyo AndroidRuntime | Set-Content -LiteralPath (Join-Path $folder '启动日志.txt') -Encoding UTF8
& $adb -s $Serial logcat -d -b crash -T $deviceTime | Set-Content -LiteralPath (Join-Path $folder '崩溃日志.txt') -Encoding UTF8
Write-Host "完成：$folder"
Write-Host '日志可能含路径和同时发生的其他应用错误。分享前请检查；提供设备信息、启动日志和崩溃日志即可。'
