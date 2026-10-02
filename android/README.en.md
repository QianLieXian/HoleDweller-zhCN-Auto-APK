# Hole Dweller Android APK Builder

**Builder version: 0.2.0-alpha.5 · Supported game: Steam Windows r44.**

Build a Chinese or English Android APK on Windows using your own copy of Hole Dweller. Both editions include touch controls and Android compatibility fixes. The game runs through a native GameMaker Android runner executing its VM bytecode.

[中文说明](README.md) · [Download](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/android-v0.2.0-alpha.5) · [Report a problem](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues)

## Build an APK

1. Download `HoleDweller-Android-Builder-v0.2.0-alpha.5.7z` from Releases and extract the entire archive into a writable folder on Windows. Do not place it inside the game installation directory.
2. Double-click **Build-APK.cmd**.
3. Choose **1. Build Chinese APK** or **2. Build English APK**. Option 2 uses English build prompts.
4. The launcher explains that build tools are required. Missing portable tools are downloaded automatically (about 144 MB), checked against a pinned SHA256 hash, and extracted into `tools`. The first build also downloads a fixed Android runner (about 32 MB).
5. Select your own Hole Dweller folder containing `data.win`.
6. Wait for the build to finish. Copy the appropriate file from `output` to your Android device and install it:

| Edition | Output file |
| --- | --- |
| Chinese | `HoleDweller-zhCN-Android-0.2.0-alpha.5.apk` |
| English | `HoleDweller-EN-Android-0.2.0-alpha.5.apk` |

The English build requires the supported original r44 `data.win`, or the `data.win.zhCN.original` backup left by this project's Chinese installer. A translated file without its original backup is rejected for English builds. Other revisions are rejected even if they are also labelled r44.

The English edition retains the original game text, character names and game font. Its touch controls, menus and confirmation prompts are in English. Chinese and English use separate Android package names, so they can coexist; their saves are independent and are not automatically migrated.

## Downloads and requirements

- Windows with PowerShell 5.1 or newer, internet access for the first build, and enough free disk space for downloaded tools and temporary APK files; keep at least 2 GB available.
- A supported, legally obtained Steam Windows r44 copy of the game.
- A 64-bit ARM Android phone or tablet. An x86_64 runner is also included for emulator testing. The manifest allows Android 5.0+, but older devices and Android devices using 16 KB memory pages have not been verified.
- Nothing is installed as a system service and no startup task is created. Tools remain inside the extracted builder folder.

The launcher detects an HTTP proxy at `127.0.0.1:7897`, or you can set `HD_ANDROID_PROXY`. Keep `tools` and `.local/runner-2024.14.apk` to avoid repeat downloads. If automatic environment download fails, download `HoleDweller-Android-Environment-v1.zip` from the same release and save it as `.local/environment-v1.zip`, then run the launcher again. The checksum is still verified.

Downloading the repository's source ZIP alone does not include the compiled tools; the launcher downloads them when needed. The release's 7z is the recommended starting point.

## Touch controls

| Control | Action |
| --- | --- |
| Tap the game scene | Left mouse click |
| UP / DOWN / LEFT / RIGHT | Directional input and camera movement |
| SPACE | Original space-key action, depending on the scene |
| Q / E beside UP | Left / right mouse button at the last scene position |
| R LOCK | Toggle right-button mode for scene touches |
| M CLICK / M LOCK | Middle-button input / toggle persistent middle-button mode |
| WH + / WH - | Mouse wheel up / down; hold to repeat |
| ZOOM | Toggle scene zoom |
| BACK | Hold to return to the title; hold on the title to exit |
| KEYS | Show or hide the touch controls |
| MENU | Display/audio, scene/resources and special actions |
| STRETCH | Toggle filling the screen or preserving the original 16:9 aspect ratio |

The display menu provides 1x–4x internal render scales, automatic scale selection, the original 60/120-frame logic toggle and cycling sound-effect volume. A 120Hz toggle does not guarantee that Android or the display will actually deliver 120Hz.

Scene actions include Space+6 to reload the scene for local MOD changes, and the original resource cheat sequence. Steam Workshop upload is unavailable on Android. F11/F12 state-changing actions require confirmation. Save deletion is behind a confirmation and a sustained hold, with cancellation on release; it is not a permanent touch button.

## Fixes and testing

- Earlier versions fixed APK resource lookup using the old package name, removed Windows Steam extension dependencies, disabled development hot reload, and corrected dialogue substring bounds.
- alpha.4 fixed an Adreno GPU deadlock when meeting Zaria at the beach. A floating-point palette loop could stop advancing under reduced precision. The replacement uses a bounded integer loop and higher precision where supported, preserving palette swapping. Custom palette images should not exceed 256 rows.
- alpha.4 was installed over the previous Chinese build on a Lenovo TB-Q706F / Android 12 without clearing saves. The user confirmed that the beach encounter dialogue completed; logs showed no repeat of the GPU deadlock.
- alpha.5 adds bilingual CMD selection, English touch UI, English game builds and automatic environment provisioning. See the release notes for its build and launch checks. Full playthroughs, every character encounter, other devices and long sessions remain unverified.

Please report the builder version, language choice, device model, Android version, steps to reproduce and the full error. No root is needed to collect crash logs: enable USB debugging, connect the device to Windows, authorize it on the device and run `Collect-Crash-Logs.cmd` (the collector currently prints Chinese status messages). Log collection does not clear saves or upload logs automatically. Review logs before sharing them publicly.

## Tools and fonts

| Component | Version and source |
| --- | --- |
| Android adaptation and builder | `src` in the release, `android/src` in the repository; new code uses MIT |
| Chinese localization | [HoleDweller-zhCN](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK), 0.1.0 |
| Android runner template | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), GameMaker 2024.14 at commit `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| apksigner / zipalign | [Android SDK Build Tools](https://developer.android.com/tools/releases/build-tools), 35.0.0 |
| ADB | [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools), 37.0.1 |
| Java | [Eclipse Temurin](https://adoptium.net/), portable 8u504 |
| Python | [Python](https://www.python.org/downloads/release/python-3137/), embedded 3.13.7 |
| Chinese pixel font | [Fusion Pixel](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px monospaced Simplified Chinese; OFL and upstream licenses are included |
| Archive format | [7-Zip](https://www.7-zip.org/) · [source](https://github.com/ip7z/7zip), 24.08 |

Chinese translations were drafted and revised individually with GPT using character tone, context and game mechanics, rather than an automatic machine-translation service. They have not received independent line-by-line human review. The English build uses the game's original English text.

The public builder contains no original game, complete APK, user save, private signing key or device log. Build an APK locally from your own game resources. Original game assets and the GameMaker runner retain their respective rights and are not covered by this project's MIT license. The runner is downloaded separately with a fixed checksum; an upstream public repository does not itself establish redistribution permission. Licenses for bundled tools and fonts are retained.

## Updating and contributing

Keep `.local/个人构建签名.jks` from your existing builder and copy it to the same location when updating. APKs signed with the same key can update the same edition in place. Do not uninstall just to resolve a signing mismatch: uninstalling can remove app saves. The included default key password is for personal test builds, not a production signing setup.

Source locations in the repository:

- `android/src/打包.py`: language choice, game verification and APK generation.
- `android/src/安卓适配.csx`: shared Android adaptation and GPU fix.
- `android/src/触屏控制.gml`: Chinese touch UI; `触屏控制-en.gml`: English touch UI with the same bindings.
- `android/Build-APK.ps1`: environment download and launcher.

For a new game revision, verify the original resources, update text mappings and adaptation scripts, rebuild both editions and test them before changing the supported hashes. Do not merely bypass version checks. For Chinese translation changes, update the localization source and regenerate its patch first. Document tests and limitations, update version numbers and both READMEs, then publish the builder and checksums in Releases. Keep old releases available for comparison.
