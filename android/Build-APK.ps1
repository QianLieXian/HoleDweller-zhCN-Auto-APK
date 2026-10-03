param([string]$GameFolder,[ValidateSet('zh','en','pt','ru','es','de','ja','fr','ko','tr')][string]$Language='zh',[switch]$MenuChoice)
$ErrorActionPreference='Stop'
if($MenuChoice) {
 $choices=@('zh','en','pt','ru','es','de','ja','fr','ko','tr')
 if($env:HD_BUILD_CHOICE -notmatch '^(?:[1-9]|10)$') {Write-Host 'Invalid choice / 无效选项'; exit 1}
 $Language=$choices[[int]$env:HD_BUILD_CHOICE-1]
}
$root=$PSScriptRoot
$translations=Get-Content -LiteralPath (Join-Path $root 'locales/launcher.json') -Raw -Encoding UTF8 | ConvertFrom-Json
function Say($zh,$en) {
 if($Language -eq 'zh') {Write-Host $zh; return}
 if($Language -eq 'en') {Write-Host $en; return}
 $key=switch -Wildcard ($en) {'Python, Java*' {'required'} 'Downloading*' {'download'} 'SHA256 verified*' {'extract'} 'Done.*' {'done'} default {''}}
 if($key) {Write-Host $translations.$Language.$key} else {Write-Host $en}
}
try {
    Say '需要便携Python、Java和安卓打包工具；缺少时将自动下载到本工具目录。' 'Python, Java and Android build tools are required; missing tools will be downloaded locally.'
    $required=@('tools\python\python.exe','tools\java\bin\java.exe','tools\java\bin\keytool.exe','tools\umt\UndertaleModCli.exe','tools\apktool.jar','tools\android\zipalign.exe','tools\android\apksigner.jar')
    $missing=@($required | Where-Object { !(Test-Path -LiteralPath (Join-Path $root $_)) })
    if($missing.Count -gt 0) {
        $local=Join-Path $root '.local'
        New-Item -ItemType Directory -Force -Path $local | Out-Null
        $envZip=Join-Path $local 'environment-v1.zip'
        $expected='eda04b13754caea798520e536412ca10dd7f2fe2664ad8f424ff221cb5e544c4'
        if(!(Test-Path -LiteralPath $envZip) -or (Get-FileHash -LiteralPath $envZip -Algorithm SHA256).Hash.ToLower() -ne $expected) {
            Say '正在下载便携打包环境，约144 MB；请稍候。' 'Downloading portable build tools (about 144 MB). Please wait.'
            [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
            $client=New-Object Net.WebClient
            try {
                $proxyUrl=$env:HD_ANDROID_PROXY
                if(!$proxyUrl) {
                    $probe=New-Object Net.Sockets.TcpClient
                    try { $connected=$probe.ConnectAsync('127.0.0.1',7897).Wait(500); if($connected -and $probe.Connected) { $proxyUrl='http://127.0.0.1:7897' } } catch {} finally { $probe.Dispose() }
                }
                if($proxyUrl) { $client.Proxy=New-Object Net.WebProxy($proxyUrl) }
                $client.DownloadFile('https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/download/android-v0.2.0-alpha.5/HoleDweller-Android-Environment-v1.zip',$envZip)
            } finally { $client.Dispose() }
        }
        if((Get-FileHash -LiteralPath $envZip -Algorithm SHA256).Hash.ToLower() -ne $expected) { throw 'Downloaded build environment failed SHA256 verification. Retry the download.' }
        Say '校验通过，正在解压便携工具。' 'SHA256 verified. Extracting portable tools.'
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $zip=[IO.Compression.ZipFile]::OpenRead($envZip)
        try {
            $base=[IO.Path]::GetFullPath($root)+[IO.Path]::DirectorySeparatorChar
            foreach($entry in $zip.Entries) {
                if(!$entry.FullName.StartsWith('tools/')) { throw 'Unexpected path in tool archive.' }
                $destination=[IO.Path]::GetFullPath((Join-Path $root $entry.FullName))
                if(!$destination.StartsWith($base,[StringComparison]::OrdinalIgnoreCase)) { throw 'Unsafe path in tool archive.' }
                if(!$entry.Name) { New-Item -ItemType Directory -Force -Path $destination | Out-Null; continue }
                New-Item -ItemType Directory -Force -Path ([IO.Path]::GetDirectoryName($destination)) | Out-Null
                [IO.Compression.ZipFileExtensions]::ExtractToFile($entry,$destination,$true)
            }
        } finally { $zip.Dispose() }
        foreach($item in $required) { if(!(Test-Path -LiteralPath (Join-Path $root $item))) { throw 'Build environment is incomplete.' } }
    }
    if(!$GameFolder) {
        Add-Type -AssemblyName System.Windows.Forms
        $dialog=New-Object System.Windows.Forms.FolderBrowserDialog
        $dialog.Description=if($Language -eq 'zh') {'请选择自己的 Hole Dweller 游戏目录（包含 data.win）。'} elseif($Language -eq 'en') {'Select your own Hole Dweller folder containing data.win.'} else {$translations.$Language.folder}
        if($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) { exit 0 }
        $GameFolder=$dialog.SelectedPath
    }
    & (Join-Path $root 'tools\python\python.exe') -X utf8 (Join-Path $root 'src\打包.py') $GameFolder --language $Language
    if($LASTEXITCODE -ne 0) { throw 'APK build failed. See the error above and .local/build logs.' }
    Say '完成：将output文件夹里的APK复制到安卓设备安装。' 'Done. Copy the APK from output to your Android device.'
} catch { Write-Host $_.Exception.Message -ForegroundColor Red; exit 1 }
