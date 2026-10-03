# Hole Dweller Windows 多语言补丁

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**版本0.2.0 · Steam Windows r44** · [下载7z](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases/tag/v0.2.0-r44)

## 安装、切换与还原

1. 退出游戏，完整解压补丁包到游戏目录之外。
2. 双击 **WindowsPatch.cmd**，选语言：1中文、2还原English、3Português、4Русский、5Español、6Deutsch、7日本語、8Français、9한국어、10Türkçe。
3. 选择含 `HoleDweller.exe` 和 `data.win` 的游戏目录。安装成功后从Steam正常启动。

首次安装将原版资源备份为 `data.win.zhCN.original`。请保留它；选择其他语言会先还原已识别的本项目补丁，再安装新语言。菜单2自动识别当前语言并还原英文，也支持旧版0.1.0中文补丁。原有字体会备份、还原；安装器不访问存档，不联网、不设开机自启。

遇到写入权限错误，右键WindowsPatch.cmd选择管理员运行。校验不符则停止，不覆盖未知版本或其他MOD；请先还原相应MOD，或用Steam验证游戏文件。游戏目录要有足够空间存放原版备份与临时输出。Windows 10/11通常自带所需.NET Framework 4.x，无需下载安卓打包环境。

## 内容与检查

中文及八种新增语言各1,464条，和安卓共用同一套译文。只改译文、字体与排版，保留桌面键鼠、Steam调用；成就同步等仍由原游戏和Steam决定。角色名、图片内文字、MOD新增台词可能保留原文。

新增语言经过资源编译、译文读取、差分往返与安装器验证；详见[版本信息](版本信息.json)及[测试记录](测试记录.json)。未完成逐语言完整游玩和独立母语者逐行审校。GPT网页High档和Codex按上下文编写修订，没有接入自动翻译服务。

## 工具与后续修改

- [UndertaleModTool 0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0)：编译游戏资源。
- [bsdiff4 1.2.6](https://github.com/ilanschnell/bsdiff4)：生成差分，仅开发重建需要Python与该库。
- [Fusion Pixel 2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25)：拉丁/西里尔、简中、日、韩字体；许可证在licenses。
- [7-Zip 24.08](https://www.7-zip.org/) · [源码](https://github.com/ip7z/7zip)：发布7z。

仓库中的 `android/locales/语言代码.game.json` 为共享译稿，`android/src/多语言排版.gml` 为共享排版；Windows源码在 `windows/src`。新增语言改译后校验格式，运行 `src/重新构建.ps1` 指定原版资源、UMT和语言，重建差分，更新版本信息中的目标资源与补丁哈希，再验证安装、还原和游戏显示。此开发脚本在完整仓库中使用；发布7z用于安装，不携带原版资源或开发环境。中文仍沿用首页src的差分重建流程。

发布时更新README、测试记录、版本和SHA256，上传新7z到Releases，保留旧版。新游戏版本要重新适配，不能只改校验值。项目新增代码MIT，游戏与工具各自保留权利，字体许可证随包保留。
