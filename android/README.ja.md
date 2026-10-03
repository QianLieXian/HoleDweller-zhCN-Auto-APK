# Hole Dweller Android APKビルダー

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**プロジェクト版：0.2.0-alpha.6。対応ゲーム：Steam Windows版 r44（元ファイルを検証）。** 自分で購入したゲームから、Windows上でAPKを作る実験的なツールです。GameMakerのAndroid用ネイティブ実行環境でVMコードを動かします。公式移植ではありません。

## APKの作り方

1. [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases)からビルダーの`.7z`をダウンロードし、書き込み可能なフォルダーにすべて展開します。ゲームのインストール先とは別の場所にしてください。
2. **Build-APK.cmd**を開き、**7. 日本語**を選びます。
3. 初回は不足するポータブルツール約144 MBと、Android実行環境約32 MBを自動ダウンロードし、SHA256を検証します。Windowsの自動起動は設定しません。
4. `data.win`があるHole Dwellerのフォルダーを選びます。対応するr44の元データ、または`data.win.zhCN.original`のバックアップが必要です。他の版は受け付けません。
5. 完了後、`output/HoleDweller-JA-Android-0.2.0-alpha.6.apk`をAndroid端末へコピーしてインストールします。

1. 简体中文 · 2. English · 3. Português · 4. Русский · 5. Español · 6. Deutsch · 7. 日本語 · 8. Français · 9. 한국어 · 10. Türkçe

Windows、PowerShell 5.1以上、初回のインターネット接続、最低2 GBの空き容量が必要です。主な対象はAndroid ARM64で、エミュレーター用にx86_64も含みます。古い端末や16 KBメモリページの環境は追加検証が必要です。`127.0.0.1:7897`のプロキシを自動検出し、別の設定は`HD_ANDROID_PROXY`で指定できます。`tools`と`.local/runner-2024.14.apk`を残せば再ダウンロードを避けられます。

## タッチ操作

| 操作 | 動作 |
| --- | --- |
| 画面をタップ | マウス左クリック |
| 方向ボタン／スペース | 方向入力／元のスペースキー動作 |
| 上ボタン横のQ／E | 最後に触れた位置で左／右クリック |
| 右クリック固定 | 画面タップを右クリックに切り替え |
| 中クリック／中クリック固定 | 中ボタン入力／継続モード |
| ホイール＋／－ | 上／下スクロール。長押しで繰り返し |
| メニュー／引き伸ばし／ボタン | 設定／画面全体に拡大／操作表示 |
| 戻る | 長押しでタイトルへ。タイトルで長押しすると終了 |

メニューから内部解像度1〜4倍、自動選択、60/120、効果音量、ローカルMOD用のシーン再読み込みを操作できます。120の設定は実際の120 Hz動作を保証しません。F11/F12相当の操作には確認が必要です。セーブ削除は確認後の長押しで実行し、指を離すと中止します。AndroidからSteam Workshopへ投稿はできません。

## 翻訳・検証・更新

翻訳はGPTのHighで、文脈・人物の口調・ゲームの仕組みを踏まえて作成、修正しています。自動翻訳サービスは使っていません。母語話者による独立した全行レビューは未実施です。人物名は原表記を維持し、画像内の文字などは原語が残る場合があります。不完全な訳文や壊れた書式ではビルドを停止します。

Zariaとの浜辺イベントで止まる問題の修正は、alpha.4をLenovo TB-Q706F／Android 12で確認しました。alpha.6の全言語で最後までプレイしたという意味ではありません。各リリースの検証記録を参照してください。不具合報告には言語、版、端末、Android版、再現手順を添えてください。`Collect-Crash-Logs.cmd`はUSB経由で、rootなし・セーブ削除なしでログを取得します。公開前に内容を確認してください。

更新時は`.local/个人构建签名.jks`を保存してください。同じ署名ならアンインストールせず更新できます。言語ごとにアプリとセーブが分かれ、自動移行はしません。鍵、セーブ、個人ログ、`data.win`、ゲーム全体入りAPKは公開しないでください。訳文修正は`locales/ja.game.json`のID、文脈、理由を添えて提案できます。ゲーム更新版は改めて検証と適合作業が必要です。

## ツール・フォント・ライセンス

| 項目 | 版・配布元 |
| --- | --- |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| Android SDK / ADB | [Build Tools 35.0.0](https://developer.android.com/tools/releases/build-tools) · [Platform Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools) |
| Java | [Eclipse Temurin 8u504](https://adoptium.net/) |
| Python | [3.13.7](https://www.python.org/downloads/release/python-3137/) |
| GameMaker | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), 2024.14, `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| Fusion Pixel | [2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px, OFL |
| 7-Zip | [24.08](https://www.7-zip.org/) · [GitHub](https://github.com/ip7z/7zip) |

日本語はFusion Pixelのja版を使用します。各ライセンスは`licenses`にあります。新規コードはMITですが、ゲーム、実行環境、外部ツールにはそれぞれの権利が適用されます。公開ビルダーにはゲーム本体や完成APKは含みません。[不具合・提案](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues)。
