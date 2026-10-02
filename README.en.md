# Hole Dweller Chinese Localization & Auto APK Builder

Unofficial Simplified Chinese localization for **Hole Dweller Steam Windows r44**, plus a Windows tool that builds Chinese or original-English Android APKs from your own game resources.

[中文说明](README.md) · [Android build instructions in English](android/README.en.md) · [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases)

## Android: build your own APK

Download the **0.2.0-alpha.5 builder 7z** from [the Android release](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/android-v0.2.0-alpha.5), extract it and run **Build-APK.cmd**. Choose **1** for Chinese or **2 — Build English APK**. Missing portable build tools are downloaded and verified automatically; then select your supported Steam game folder. The resulting APK is written to `output`.

English builds preserve the original English game text and include English touch controls and menus. Chinese builds add the localization and pixel font. Both editions include Android compatibility fixes, touch inputs and a stretch toggle. They use separate package names and independent saves.

| Project part | Version |
| --- | --- |
| Android APK builder | 0.2.0-alpha.5, experimental |
| Windows Chinese patch | 0.1.0 |
| Supported game resources | Steam Windows r44, verified by SHA256 |
| Chinese pixel font | Fusion Pixel 12px, 2026.09.25 |

Both alpha.5 APKs build and pass signing/alignment checks. alpha.4's beach encounter GPU fix was tested on a Lenovo TB-Q706F running Android 12. alpha.5 has not yet been run on a physical device; full playthroughs and other devices remain unverified. Read the [full English Android README](android/README.en.md) for requirements, controls, tool and font links, troubleshooting and update instructions.

## Windows Chinese patch

The separate [v0.1.0-r44 release](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/v0.1.0-r44) contains the Windows patch installer. Extract its 7z, run the Chinese installation launcher and select the game directory. A restore launcher is included. The [Chinese project README](README.md) covers installation and translation maintenance.

Translations were drafted and revised individually with GPT using context and character tone, rather than an automatic machine-translation service; independent human review is still pending. The English Android build uses the original game text.

## Contributing and distribution

Report problems with the version, language, device/OS and reproduction steps in [Issues](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues). Android source is in `android/src`; localization source is in `src`. Preserve your local signing key when updating the builder to keep installing updates over the same edition.

Public releases contain builders and patches, not the original game, complete APKs, saves or private signing keys. Use your own game copy. New project code uses MIT; fonts, tools, game assets and the runner retain their respective licenses. Tool and font links are listed in the [English Android documentation](android/README.en.md#tools-and-fonts).
