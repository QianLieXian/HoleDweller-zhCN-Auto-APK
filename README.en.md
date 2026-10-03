# Hole Dweller Localization & Auto APK Builder

Unofficial localization for **Steam Windows r44**: install language patches on Windows, or build native Android APKs from your own game copy.

[简体中文](README.md) · [Issues](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues)

## Downloads

| Platform | Version | Download and guide |
| --- | --- | --- |
| Windows language patches | **0.2.0** | [Builder-free patch 7z](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/v0.2.0-r44) · [Windows guide](windows/README.en.md) |
| Android APK builder | **0.2.0-alpha.6** | [Builder 7z](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/android-v0.2.0-alpha.6) · [Android guide](android/README.en.md) |

Download the release asset and extract the entire archive. Resources are verified by a fixed hash; other packages labelled r44 may be incompatible. Release date: 3 October 2026.

## Languages

| Menu | Language | Windows | Android |
| --- | --- | --- | --- |
| 1 | 简体中文 | [Guide](windows/README.md) | [Guide](android/README.md) |
| 2 | English | [Guide](windows/README.en.md) | [Guide](android/README.en.md) |
| 3 | Português brasileiro | [Guia](windows/README.pt.md) | [Guia](android/README.pt.md) |
| 4 | Русский | [Инструкция](windows/README.ru.md) | [Инструкция](android/README.ru.md) |
| 5 | Español | [Guía](windows/README.es.md) | [Guía](android/README.es.md) |
| 6 | Deutsch | [Anleitung](windows/README.de.md) | [Anleitung](android/README.de.md) |
| 7 | 日本語 | [説明](windows/README.ja.md) | [説明](android/README.ja.md) |
| 8 | Français | [Guide](windows/README.fr.md) | [Guide](android/README.fr.md) |
| 9 | 한국어 | [설명](windows/README.ko.md) | [설명](android/README.ko.md) |
| 10 | Türkçe | [Kılavuz](windows/README.tr.md) | [Kılavuz](android/README.tr.md) |

Chinese and each of the eight new languages cover 1,464 selected entries: interface, dialogue, items, tutorials and achievements. English uses the original text; Windows choice 2 restores it. Names, image text and third-party MOD additions may remain untranslated.

## Quick start

**Windows:** close the game, extract the patch archive, run **WindowsPatch.cmd**, choose a language and select your game folder. The original is backed up automatically. Switching recognized project patches is supported; choice 2 restores English. Desktop input and Steam calls are retained. Saves are untouched and unrecognized modified resources are rejected.

**Android:** extract the builder, run **Build-APK.cmd**, choose a language and your game folder. Missing portable tools and the runner download automatically; proxy port7897 is supported, and no startup tasks are created. Find your APK in `output`. Each language has independent saves. Preserve `.local/个人构建签名.jks` when updating the builder.

## Quality and maintenance

Translations were drafted and edited contextually with GPT at High and Codex, without automatic translation services. Independent native-speaker review remains pending. Windows patches pass resource compilation, delta roundtrip, install/switch/restore and rejection tests; full playthroughs in every language are unverified. All ten Android builds pass signing, alignment and resource checks; alpha.6 device testing remains pending. See the platform test records.

Tool sources: [UndertaleModTool 0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0), [bsdiff4 1.2.6](https://github.com/ilanschnell/bsdiff4), [Fusion Pixel 2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), [7-Zip 24.08](https://github.com/ip7z/7zip). Full Android tool links are in the [Android guide](android/README.en.md#tools-and-fonts); font licenses are included.

Translations are shared in `android/locales`; Windows build source is in `windows/src`, Android source in `android/src`, and legacy Chinese source in `src`. Validate changes, rebuild the affected patches/APKs, test, update documentation and hashes, then publish a new release. Re-adapt new game revisions rather than bypassing hash checks.

New project code uses MIT. Fonts, tools, game assets and the runner retain their own licenses. Public releases contain patches and builders, without original game files, complete APKs, saves or private keys.
