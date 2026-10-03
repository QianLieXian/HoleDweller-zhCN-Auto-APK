# Hole Dweller Windows Language Patches

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**0.2.0 · Steam Windows r44** · [Download 7z](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/v0.2.0-r44)

## Install, switch and restore

1. Close the game and extract the entire patch archive outside the game directory.
2. Run **WindowsPatch.cmd**. Choose 1 Chinese, 2 original English, 3 Portuguese, 4 Russian, 5 Spanish, 6 German, 7 Japanese, 8 French, 9 Korean or 10 Turkish.
3. Select the folder containing `HoleDweller.exe` and `data.win`. Start the game normally through Steam after installation.

The original is backed up as `data.win.zhCN.original`; keep it. Switching languages restores a recognized project patch before installing the selected one. Choice2 detects the current language and restores English, including the old Chinese0.1.0 patch. Existing fonts are backed up and restored. Saves are untouched. The installer runs offline and adds no startup tasks.

If access is denied, run the launcher as administrator. Unknown versions or modified MOD resources are rejected; restore those changes or verify the game through Steam first. Allow disk space for the original backup and temporary output. Windows10/11 normally includes the required .NET Framework4.x. Android build tools are unnecessary.

## Content and checks

Chinese and eight added languages each cover 1,464 selected entries, shared with Android. Desktop input and Steam calls remain intact; original-game/Steam behavior determines achievement syncing. Names, image text and MOD additions may remain untranslated.

Resource compilation, translated-string inspection, delta roundtrip and installer lifecycle tests pass. See [version details](版本信息.json) and [test record](测试记录.json). Full playthroughs in every language and independent native-speaker review remain pending. Text was drafted contextually with GPT at High and Codex, without automatic translation services.

## Tools and maintenance

| Tool | Version / source |
| --- | --- |
| Resource compiler | [UndertaleModTool0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Delta generator | [bsdiff4 1.2.6](https://github.com/ilanschnell/bsdiff4), Python development dependency |
| Pixel fonts | [Fusion Pixel2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), latin/Cyrillic, zh_hans, ja, ko; licenses included |
| Archive | [7-Zip24.08](https://github.com/ip7z/7zip) |

Shared catalogs are in repository `android/locales`; shared wrapping code is `android/src/多语言排版.gml`. Windows source is `windows/src`. After editing a catalog, validate formatting and rebuild with `src/重新构建.ps1`, supplying original resources, UMT and the language. Update target/patch hashes in version metadata and test installation, restoration and rendering. The development script requires the full source repository; the release archive is for installation. Chinese patch rebuilding uses the legacy root `src` workflow.

Update versions, documentation and checksums before a new release. Preserve old releases. Re-adapt new game revisions rather than bypassing checks. New project code is MIT; game assets, tools and fonts retain their licenses. No original game, saves or private backups are distributed.
