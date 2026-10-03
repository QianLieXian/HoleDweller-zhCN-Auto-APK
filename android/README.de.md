# Hole Dweller — APK-Builder für Android

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**Projektversion: 0.2.0-alpha.6. Unterstütztes Spiel: Steam Windows r44 mit Prüfung der Originaldatei.** Dieses experimentelle Werkzeug erstellt lokal ein APK aus deiner eigenen Spielkopie. Der VM-Code läuft in einer nativen GameMaker-Laufzeit für Android. Es handelt sich um einen inoffiziellen Port.

## APK erstellen

1. Lade das `.7z`-Archiv des Builders aus [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases) herunter. Entpacke es vollständig in einen beschreibbaren Windows-Ordner außerhalb des Spielordners.
2. Öffne **Build-APK.cmd** und wähle **6. Deutsch**.
3. Beim ersten Start werden fehlende portable Werkzeuge automatisch heruntergeladen: etwa 144 MB sowie 32 MB für die Android-Laufzeit. SHA256-Prüfsummen werden kontrolliert. Es wird kein Windows-Autostart eingerichtet.
4. Wähle den Hole-Dweller-Ordner mit `data.win`. Benötigt wird das unterstützte r44-Original oder die Sicherung `data.win.zhCN.original`. Andere Fassungen werden abgelehnt.
5. Übertrage `output/HoleDweller-DE-Android-0.2.0-alpha.6.apk` auf dein Android-Gerät und installiere es.

1. 简体中文 · 2. English · 3. Português · 4. Русский · 5. Español · 6. Deutsch · 7. 日本語 · 8. Français · 9. 한국어 · 10. Türkçe

Voraussetzungen: Windows, PowerShell 5.1+, Internet beim ersten Start und mindestens 2 GB freier Speicher. Hauptziel ist Android ARM64; x86_64 ist für Emulatortests enthalten. Alte Geräte und 16-KB-Speicherseiten benötigen weitere Tests. Der Proxy `127.0.0.1:7897` wird erkannt; über `HD_ANDROID_PROXY` lässt sich ein anderer angeben. Bewahre `tools` und `.local/runner-2024.14.apk` auf, um erneute Downloads zu vermeiden.

## Steuerung

| Eingabe | Wirkung |
| --- | --- |
| Szene antippen | Linksklick |
| Pfeile / LEER | Richtung / ursprüngliche Leertastenaktion |
| Q / E neben dem Aufwärtspfeil | Linke / rechte Maustaste an der letzten Berührungsposition |
| Rechts-Fixierung | Rechtsklickmodus umschalten |
| Mittelklick / Mittel-Fixierung | Mittlere Taste / dauerhafter Modus |
| Rad + / - | Nach oben / unten scrollen; halten zum Wiederholen |
| Menü / Strecken / Tasten | Einstellungen / Bildschirm füllen / Steuerung anzeigen |
| Zurück | Halten: Titelbild; dort halten: beenden |

Das Menü bietet interne Auflösung 1×–4×, automatische Skalierung, 60/120, Lautstärke und Szenenneustart für lokale MODs. 120 garantiert keine tatsächlichen 120 Hz. F11/F12 verlangen eine Bestätigung. Das Löschen eines Spielstands verlangt Bestätigung und längeres Halten; Loslassen bricht ab. Steam-Workshop-Uploads sind unter Android nicht verfügbar.

## Übersetzung, Tests und Updates

Die Übersetzungen wurden mit GPT auf High anhand von Kontext, Figuren und Mechaniken erstellt und überarbeitet, ohne automatischen Übersetzungsdienst. Eine unabhängige Prüfung aller Zeilen durch Muttersprachler steht noch aus. Figurennamen bleiben erhalten; Text in Bildern kann in der Originalsprache bleiben. Unvollständige oder falsch formatierte Kataloge verhindern den Build.

Die Korrektur des Zaria-Absturzes am Strand wurde mit alpha.4 auf einem Lenovo TB-Q706F / Android 12 bestätigt. Das belegt keinen vollständigen Durchlauf von alpha.6 in jeder Sprache. Beachte den Testbericht des Releases. Fehlerberichte sollten Sprache, Version, Gerät, Android-Version und Schritte enthalten. `Collect-Crash-Logs.cmd` liest USB-Protokolle ohne Root und ohne Spielstände zu löschen; prüfe sie vor der Veröffentlichung.

Behalte beim Update `.local/个人构建签名.jks`: derselbe Schlüssel erlaubt ein Update ohne Deinstallation. Jede Sprache nutzt ein eigenes Paket mit separaten Spielständen; es gibt keine automatische Übertragung. Veröffentliche keine Schlüssel, Spielstände, privaten Protokolle, `data.win` oder APKs mit dem ganzen Spiel. Reiche Sprachkorrekturen in `locales/de.game.json` mit ID, Kontext und Begründung ein. Neue Spielversionen benötigen erneute Prüfung und Anpassung.

## Werkzeuge, Schrift und Lizenzen

| Komponente | Version und Quelle |
| --- | --- |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| Android SDK / ADB | [Build Tools 35.0.0](https://developer.android.com/tools/releases/build-tools) · [Platform Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools) |
| Java | [Eclipse Temurin 8u504](https://adoptium.net/) |
| Python | [3.13.7](https://www.python.org/downloads/release/python-3137/) |
| GameMaker | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), 2024.14, `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| Fusion Pixel | [2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px, OFL |
| 7-Zip | [24.08](https://www.7-zip.org/) · [GitHub](https://github.com/ip7z/7zip) |

Deutsch nutzt Fusion Pixel latin; Japanisch und Koreanisch nutzen eigene Varianten. Lizenzen liegen in `licenses`. Neuer Code steht unter MIT; Spiel, Laufzeit und Drittkomponenten behalten ihre jeweiligen Rechte. Der öffentliche Builder enthält weder das Spiel noch fertige Spiel-APKs. [Fehler und Vorschläge](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues).
