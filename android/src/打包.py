"""个人本地构建：读取用户的游戏，应用汉化，再适配 Android；不上传游戏文件。"""
import argparse, gzip, hashlib, json, os, pathlib, shutil, struct, subprocess, sys
import socket, urllib.request, xml.etree.ElementTree as ET
sys.path.insert(0,str(pathlib.Path(__file__).resolve().parent))
from 检查语言 import check as check_language

ROOT = pathlib.Path(__file__).resolve().parent.parent
TOOLS = ROOT / 'tools'
WORK = ROOT / '.local'
ORIGINAL = '5123c1404fa33996b6d07673584b0bd0c8bd81a173d88abe380e3a49785ce68b'
CHINESE = '45b473e7637efcd6b14d098a31d1221130ba55b1a26b534e39af1160032503d3'
RUNNER_SHA = 'eb9ca9c02f255a6790bb131083b5d21a0a7f7f0bf110940bcacdd617e09a4f4f'
RUNNER_URL = 'https://raw.githubusercontent.com/znm2500/GameMaker-Mobiler/6a23adc1d4e71c238456568df18f85cc7b44caa9/GMS2%20APK/2024.14.apk'
PACKAGE = 'io.github.qianliexian.holedweller.zhcn'
JAVA = TOOLS / 'java' / 'bin' / 'java.exe'
KEYTOOL = TOOLS / 'java' / 'bin' / 'keytool.exe'

UI=json.loads((ROOT/'locales/launcher.json').read_text(encoding='utf-8'))
def sha(data): return hashlib.sha256(data).hexdigest()
def run(args, log):
    with open(log, 'a', encoding='utf-8') as f:
        proc = subprocess.run([str(a) for a in args], stdout=f, stderr=subprocess.STDOUT, env=os.environ.copy())
    if proc.returncode: raise RuntimeError('构建工具失败，详见：' + str(log))

def chinese_bytes(data):
    h = sha(data)
    if h == CHINESE: return data
    if h != ORIGINAL: raise ValueError('游戏版本不匹配。仅支持本项目适配的 Steam Windows r44 原版，或已安装本项目 0.1.0 汉化的资源。')
    p = (ROOT / 'patch' / '汉化补丁.hdp').read_bytes()
    # HDZH1 + 三个零字节 + 两个 SHA256 + 四个 int64，与现有离线安装器相同。
    if p[:8] != b'HDZH1\0\0\0': raise ValueError('补丁格式不匹配')
    if p[8:40].hex() != ORIGINAL or p[40:72].hex() != CHINESE: raise ValueError('补丁校验头不匹配')
    size, count, diff_len, extra_len = struct.unpack_from('<qqqq', p, 72)
    payload = gzip.decompress(p[104:])
    if len(payload) != count * 24 + diff_len + extra_len: raise ValueError('补丁长度不符')
    result = bytearray(size); oldpos = newpos = 0
    diffpos = count * 24; extrapos = diffpos + diff_len
    for k in range(count):
        x, y, z = struct.unpack_from('<qqq', payload, k * 24)
        if min(x,y)<0 or newpos+x+y>size or diffpos+x>count*24+diff_len or extrapos+y>len(payload): raise ValueError('差分越界')
        for j in range(x):
            prev = data[oldpos+j] if 0 <= oldpos+j < len(data) else 0
            result[newpos+j] = (prev + payload[diffpos+j]) & 255
        newpos += x; oldpos += x; diffpos += x
        result[newpos:newpos+y] = payload[extrapos:extrapos+y]
        newpos += y; extrapos += y; oldpos += z
    if newpos != size or sha(result) != CHINESE: raise ValueError('汉化生成校验失败')
    return result

def obtain_runner():
    path = WORK / 'runner-2024.14.apk'
    if not path.exists() or sha(path.read_bytes()) != RUNNER_SHA:
        lang=os.environ.get('HD_ANDROID_LANGUAGE','zh')
        print(UI[lang]['runner'] if lang in UI else ('Downloading the fixed Android runner (about 32 MB).' if lang=='en' else '首次构建：下载固定版本安卓运行器（约32 MB）。'),flush=True)
        proxy_url = os.environ.get('HD_ANDROID_PROXY')
        if proxy_url is None:
            try:
                with socket.create_connection(('127.0.0.1',7897),timeout=0.5): proxy_url = 'http://127.0.0.1:7897'
            except OSError: proxy_url = ''
        proxy = urllib.request.ProxyHandler({'http':proxy_url,'https':proxy_url}) if proxy_url else urllib.request.ProxyHandler()
        opener = urllib.request.build_opener(proxy)
        with opener.open(RUNNER_URL, timeout=120) as r: content = r.read()
        if sha(content) != RUNNER_SHA: raise ValueError('运行器下载校验失败')
        path.write_bytes(content)
    return path

def main():
    parser = argparse.ArgumentParser(); parser.add_argument('game'); parser.add_argument('--runner'); parser.add_argument('--language', choices=['zh','en','pt','ru','es','de','ja','fr','ko','tr'], default='zh'); args = parser.parse_args()
    global PACKAGE
    language = args.language
    config=json.loads((ROOT/'locales/languages.json').read_text(encoding='utf-8'))[language]
    PACKAGE=config['package']
    label='Hole Dweller - '+config['name']
    def say(zh,en):
        if language in UI and en[:1] in '12345':
            key='step'+en[0]; message=UI[language][key]
            if key=='step5': message+=en.split('Output: ',1)[1]
            print(message,flush=True)
        else: print(en if language=='en' else zh,flush=True)
    game = pathlib.Path(args.game)
    source = game / 'data.win' if game.is_dir() else game
    # 优先使用安装器保留的原版，但不更改它。
    if source.with_name('data.win.zhCN.original').is_file(): source = source.with_name('data.win.zhCN.original')
    original = source.read_bytes()
    if language != 'zh':
        if sha(original) != ORIGINAL: raise ValueError('This language requires the supported original Steam r44 data.win or its data.win.zhCN.original backup.')
        translated = original
        if language != 'en':
            pack=ROOT/'locales'/config['game_file']
            if not pack.is_file(): raise ValueError('Language translation is not complete yet: '+config['name'])
            catalog=json.loads(pack.read_text(encoding='utf-8'))
            expected=json.loads((ROOT/'locales/catalog.json').read_text(encoding='utf-8'))
            if set(catalog)!=set(expected) or any(not isinstance(v,str) or not v.strip() for v in catalog.values()): raise ValueError('Incomplete language translation: '+config['name'])
            check_language(language)
    else:
        translated = chinese_bytes(original)
    WORK.mkdir(exist_ok=True)
    build = WORK / 'build'
    if build.is_symlink() or (hasattr(build,'is_junction') and build.is_junction()): raise ValueError('构建目录不能是链接或目录联接')
    if build.exists(): shutil.rmtree(build)  # 固定于本工具 .local/build，绝不操作用户游戏目录。
    build.mkdir()
    log = build / '构建日志.txt'
    log.write_text('Hole Dweller 安卓实验构建 0.2.0-alpha.6\n', encoding='utf-8')
    input_data = build / 'zhCN.win'; input_data.write_bytes(translated)
    say('1/5 正版资源校验与汉化完成。', '1/5 Game resources verified; language selected.')
    os.environ['HD_ANDROID_PROJECT'] = str(ROOT)
    os.environ['HD_ANDROID_LANGUAGE'] = language
    os.environ['HD_ANDROID_FONT'] = config['font'] or ''
    if language not in ['zh','en']:
        localized=build/'localized.win'
        run([TOOLS/'umt'/'UndertaleModCli.exe','load',input_data,'-s',ROOT/'src'/'多语言本地化.csx','-o',localized,'-f'],log)
        if not localized.is_file(): raise RuntimeError('Localization adapter failed')
        input_data=localized
    mobile_data = build / 'game.droid'
    run([TOOLS/'umt'/'UndertaleModCli.exe','load',input_data,'-s',ROOT/'src'/'安卓适配.csx','-o',mobile_data,'-f'],log)
    build_log = log.read_text(encoding='utf-8')
    if not mobile_data.is_file() or any(e in build_log for e in ('Script execution failed','Script compilation failed','Code import unsuccessful')): raise RuntimeError('安卓适配脚本失败')
    say('2/5 触屏与安卓适配完成。', '2/5 Touch controls and Android fixes applied.')
    runner = pathlib.Path(args.runner) if args.runner else obtain_runner()
    if sha(runner.read_bytes()) != RUNNER_SHA: raise ValueError('运行器版本或校验值不匹配')
    decoded = build/'decoded'
    run([JAVA,'-Xmx512m','-XX:ActiveProcessorCount=1','-jar',TOOLS/'apktool.jar','d',runner,'-j','1','-o',decoded,'-f'],log)
    say('3/5 安卓运行器解包完成。', '3/5 Android runner unpacked.')
    # 模板的 DemoRenderer 用硬编码包名查询 APK 路径。
    # 仅修改应用包名字符串；保留 Java 类名及 JNI 接口，避免破坏原生库绑定。
    package_literals = 0
    for smali in decoded.glob('smali*/**/*.smali'):
        source_text = smali.read_text(encoding='utf-8')
        package_literals += source_text.count('"com.company.game"')
        updated = source_text.replace('"com.company.game"', '"'+PACKAGE+'"')
        if updated != source_text: smali.write_text(updated,encoding='utf-8')
    if package_literals == 0: raise RuntimeError('运行器模板结构变化，未找到预期的应用包名配置')
    android = '{http://schemas.android.com/apk/res/android}'
    ET.register_namespace('android',android[1:-1])
    manifest_path = decoded/'AndroidManifest.xml'
    tree = ET.parse(manifest_path); manifest = tree.getroot(); manifest.set('package',PACKAGE)
    for permission in list(manifest.findall('uses-permission')):
        if permission.get(android+'name','').startswith('android.permission.'):
            manifest.remove(permission)  # 不请求联网、蓝牙、存储等权限。
    app = manifest.find('application'); app.set(android+'label',label)
    app.set(android+'extractNativeLibs','true')
    app.set(android+'allowBackup','false')
    for node in manifest.iter():
        for k,v in list(node.attrib.items()):
            if 'DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION' in v or k == android+'authorities': node.set(k,v.replace('com.company.game',PACKAGE))
    activity = app.find('activity')
    activity.set(android+'screenOrientation','sensorLandscape')
    activity.set(android+'label',label)
    for metadata in app.findall('meta-data'):
        if metadata.get(android+'name') == 'IsBuiltAsYoYoRunner': metadata.set(android+'value','No')
    tree.write(manifest_path,encoding='utf-8',xml_declaration=True)
    yml = decoded/'apktool.yml'
    text = yml.read_text(encoding='utf-8').replace('versionCode: 1000000','versionCode: 20006').replace('versionName: 1.0.0','versionName: 0.2.0-alpha.6')
    yml.write_text(text,encoding='utf-8')
    shutil.copyfile(mobile_data,decoded/'assets'/'game.droid')
    shutil.copyfile(ROOT/'assets'/'fusion-pixel-12px-monospaced-zh_hans.ttf',decoded/'assets'/'fusion-pixel-12px-monospaced-zh_hans.ttf')
    if language not in ['zh','en']: shutil.copyfile(ROOT/'assets'/config['font'],decoded/'assets'/config['font'])
    # 字体许可证也随用户生成的 APK 保留。
    shutil.copytree(ROOT/'licenses',decoded/'assets'/'licenses',dirs_exist_ok=True)
    (decoded/'assets'/'options.ini').write_text(('[Android]\nDisplayName="Hole Dweller 汉化测试版"\nPackageDomain="io.github"\nPackageCompany="qianliexian"\nPackageProduct="holedweller.zhcn"\nOrientLandscape=-1\nOrientPortrait=0\nOrientLandscapeFlipped=-1\nOrientPortraitFlipped=0\nDebug=False\nYYUse24Bit=0\nSplashscreenTime=0\nSleepMargin=4\nUseShaders=True\n').replace('Hole Dweller 汉化测试版', label).replace('PackageProduct="holedweller.zhcn"','PackageProduct="holedweller.' + ('zhcn' if language == 'zh' else language) + '"'),encoding='utf-8')
    unsigned = build/'unsigned.apk'; aligned = build/'aligned.apk'
    run([JAVA,'-Xmx512m','-XX:ActiveProcessorCount=1','-jar',TOOLS/'apktool.jar','b',decoded,'-j','1','-o',unsigned],log)
    run([TOOLS/'android'/'zipalign.exe','-P','16','-f','4',unsigned,aligned],log)
    say('4/5 APK 重建与对齐完成。', '4/5 APK rebuilt and aligned.')
    key = WORK/'个人构建签名.jks'
    if not key.exists():
        run([KEYTOOL,'-genkeypair','-keystore',key,'-alias','hd-local','-storepass','android','-keypass','android','-keyalg','RSA','-keysize','2048','-validity','10000','-dname','CN=Hole Dweller Personal Build','-noprompt'],log)
    output = ROOT/'output'; output.mkdir(exist_ok=True)
    apk = output/('HoleDweller-' + ('zhCN' if language == 'zh' else language.upper()) + '-Android-0.2.0-alpha.6.apk')
    run([JAVA,'-jar',TOOLS/'android'/'apksigner.jar','sign','--ks',key,'--ks-pass','pass:android','--ks-key-alias','hd-local','--out',apk,aligned],log)
    run([JAVA,'-jar',TOOLS/'android'/'apksigner.jar','verify','--verbose',apk],log)
    run([TOOLS/'android'/'zipalign.exe','-c','-P','16','4',apk],log)
    (output/(apk.name+'.sha256')).write_text(sha(apk.read_bytes())+'  '+apk.name+'\n',encoding='utf-8')
    say('5/5 签名、对齐检查通过。生成位置：'+str(apk), '5/5 Signing and alignment checks passed. Output: '+str(apk))

if __name__ == '__main__':
    try: main()
    except Exception as e:
        lang=sys.argv[sys.argv.index('--language')+1] if '--language' in sys.argv else 'zh'
        print((UI[lang]['failed'] if lang in UI else ('Build failed: ' if lang=='en' else '构建失败：'))+str(e),file=sys.stderr); sys.exit(1)
