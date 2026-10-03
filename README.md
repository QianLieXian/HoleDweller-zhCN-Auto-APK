# Hole Dweller 多语言补丁与自动 APK 打包

适用于 **Steam Windows r44** 的非官方本地化项目。Windows 提供语言补丁，安卓提供使用自己正版游戏资源生成 APK 的打包器。

[English](README.en.md) · [下载](#下载与版本) · [反馈问题](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues)

## 下载与版本

| 平台 | 当前版本 | 下载与说明 |
| --- | --- | --- |
| Windows 多语言补丁 | **0.2.0** | [下载7z](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/v0.2.0-r44) · [Windows说明](windows/README.md) |
| 安卓自动APK打包器 | **0.2.0-alpha.6** | [下载7z](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/android-v0.2.0-alpha.6) · [安卓说明](android/README.md) |

请下载对应 Release 的7z附件并完整解压。支持的游戏资源有固定校验；同样标为r44的其他发行包也可能不兼容。发布日期：2026年10月3日。

## 语言

| 菜单 | 语言 | Windows说明 | 安卓说明 |
| --- | --- | --- | --- |
| 1 | 简体中文 | [中文](windows/README.md) | [中文](android/README.md) |
| 2 | English | [English](windows/README.en.md) | [English](android/README.en.md) |
| 3 | Português（巴西葡萄牙语） | [Português](windows/README.pt.md) | [Português](android/README.pt.md) |
| 4 | Русский | [Русский](windows/README.ru.md) | [Русский](android/README.ru.md) |
| 5 | Español | [Español](windows/README.es.md) | [Español](android/README.es.md) |
| 6 | Deutsch | [Deutsch](windows/README.de.md) | [Deutsch](android/README.de.md) |
| 7 | 日本語 | [日本語](windows/README.ja.md) | [日本語](android/README.ja.md) |
| 8 | Français | [Français](windows/README.fr.md) | [Français](android/README.fr.md) |
| 9 | 한국어 | [한국어](windows/README.ko.md) | [한국어](android/README.ko.md) |
| 10 | Türkçe | [Türkçe](windows/README.tr.md) | [Türkçe](android/README.tr.md) |

中文及八种新增语言各覆盖1,464条选定游戏文本，包括界面、对白、道具、教程和成就。英文使用原版文本；Windows菜单2还原英文。人物名和图片内文字可能保留原文，第三方MOD新增文本不在覆盖范围内。

## 使用

**Windows：** 退出游戏，解压补丁包，运行 **WindowsPatch.cmd**，选语言，再选游戏目录。首次安装备份原版，已知本项目语言可自动切换；选2还原英文。原有键鼠和Steam调用保留，安装器不访问存档。已修改的其他版本或MOD资源会被拒绝。

**安卓：** 解压打包器，运行 **Build-APK.cmd**，选语言和游戏目录。首次自动下载便携环境与运行器，支持7897代理，不设开机自启。生成的APK在 `output`；不同语言使用独立包名和存档。更新打包器时保留 `.local/个人构建签名.jks`。

## 翻译与验证

译稿由GPT网页High档及Codex结合上下文编写、修订，没有接入自动翻译服务；独立母语者逐行审校仍待进行。欢迎附条目ID、截图和建议反馈。

Windows新增语言已完成资源编译、差分往返、安装、切换、还原和版本拒绝检查；未完成逐语言完整游玩。安卓十语言APK通过构建、签名、对齐和资源检查，alpha.6尚未实机运行。详情见[Windows测试记录](windows/测试记录.json)和[安卓测试记录](android/测试记录.md)。

## 工具与维护

| 项目 | 来源与版本 |
| --- | --- |
| 资源编译 | [UndertaleModTool](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0)，0.9.2.0 |
| 差分生成 | [bsdiff4](https://github.com/ilanschnell/bsdiff4)，1.2.6 |
| 像素字体 | [Fusion Pixel](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25)，2026.09.25，OFL及上游许可证随包保留 |
| 压缩 | [7-Zip](https://www.7-zip.org/) · [开源代码](https://github.com/ip7z/7zip)，24.08 |
| 安卓环境 | Python、Java、Apktool、Android SDK与运行器的版本和来源见[安卓说明](android/README.en.md#tools-and-fonts) |

Windows新增语言与安卓共用 `android/locales` 的译稿；Windows构建源码在 `windows/src`，安卓在 `android/src`，旧版中文补丁源码在 `src`。改译后校验格式，重建对应平台并测试，更新版本、README和校验文件，再发布新的Release；旧版保留以便回退。游戏更新时重新适配资源，不能只改校验值。

项目新增代码采用MIT。字体、工具、原游戏及运行器各自遵循其许可。公开附件只提供补丁和打包工具，不包含原版游戏、完整APK、存档或私人签名；完整APK由玩家本地生成。
