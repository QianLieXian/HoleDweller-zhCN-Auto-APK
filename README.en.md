# Hole Dweller Multilingual Localization & Auto APK Builder

Unofficial localization for **Hole Dweller Steam Windows r44**, plus a Windows tool that builds Android APKs in ten languages from your own game resources.

[中文说明](README.md) · [Android build instructions in English](android/README.en.md) · [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases)

## Android: build your own APK

Download the **0.2.0-alpha.6 builder 7z** from [the Android release](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/android-v0.2.0-alpha.6), extract it and run **Build-APK.cmd**. Choose a language from the menu below. Missing portable build tools are downloaded and verified automatically; then select your supported Steam game folder. The resulting APK is written to `output`.

| Choice | Complete build guide |
| --- | --- |
| 1 | [简体中文](android/README.md) |
| 2 | [English](android/README.en.md) |
| 3 | [Português brasileiro](android/README.pt.md) |
| 4 | [Русский](android/README.ru.md) |
| 5 | [Español](android/README.es.md) |
| 6 | [Deutsch](android/README.de.md) |
| 7 | [日本語](android/README.ja.md) |
| 8 | [Français](android/README.fr.md) |
| 9 | [한국어](android/README.ko.md) |
| 10 | [Türkçe](android/README.tr.md) |

English builds preserve the original English game text. Localized builds include the selected translation, matching pixel font, touch controls and menus. All editions include Android compatibility fixes and a stretch toggle. They use separate package names and independent saves. Each of the eight new languages includes all 1,464 selected game entries; names and text embedded in images may remain in the original language.

| Project part | Version |
| --- | --- |
| Android APK builder | 0.2.0-alpha.6, experimental |
| Windows Chinese patch | 0.1.0 |
| Supported game resources | Steam Windows r44, verified by SHA256 |
| Chinese pixel font | Fusion Pixel 12px, 2026.09.25 |

All ten alpha.6 APKs build and pass signing, alignment and final resource inspection. The new game and touch translations have no missing font glyphs. alpha.4's beach encounter GPU fix was tested on a Lenovo TB-Q706F running Android 12. alpha.6 has not yet been run on a physical device; full playthroughs and other devices remain unverified. Read the [full English Android README](android/README.en.md) for requirements, controls, tool and font links, troubleshooting and update instructions.

## Windows Chinese patch

The separate [v0.1.0-r44 release](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/v0.1.0-r44) contains the Windows patch installer. Extract its 7z, run the Chinese installation launcher and select the game directory. A restore launcher is included. The [Chinese project README](README.md) covers installation and translation maintenance.

Translations were drafted and revised with GPT at High and Codex using context and character tone, without automatic translation services. Codex directly translated the last 464 French and Turkish entries. Independent native-speaker review is still pending. The English Android build uses the original game text.

## Contributing and distribution

Report problems with the version, language, device/OS and reproduction steps in [Issues](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues). Android source is in `android/src`; localization source is in `src`. Preserve your local signing key when updating the builder to keep installing updates over the same edition.

Public releases contain builders and patches, not the original game, complete APKs, saves or private signing keys. Use your own game copy. New project code uses MIT; fonts, tools, game assets and the runner retain their respective licenses. Tool and font links are listed in the [English Android documentation](android/README.en.md#tools-and-fonts).
