# Hole Dweller — Android APK oluşturucu

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**Proje sürümü: 0.2.0-alpha.6. Desteklenen oyun: özgün dosyası doğrulanan Steam Windows r44.** Bu deneysel araç, kendi oyun kopyanızdan yerel bir APK oluşturur. VM kodu, Android için yerel GameMaker çalışma ortamında çalışır. Resmî bir uyarlama değildir.

## APK oluşturma

1. [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases) bölümünden oluşturucunun `.7z` arşivini indirin. Oyun klasörünün dışında, yazılabilir bir Windows klasörüne tamamen çıkarın.
2. **Build-APK.cmd** dosyasını açın ve **10. Türkçe** seçeneğini seçin.
3. İlk çalıştırmada eksik taşınabilir araçlar otomatik indirilir: yaklaşık 144 MB, ardından Android çalışma ortamı için 32 MB. SHA256 değerleri doğrulanır. Windows başlangıcına görev eklenmez.
4. `data.win` içeren Hole Dweller klasörünü seçin. Desteklenen r44 özgün dosyası veya `data.win.zhCN.original` yedeği gerekir. Diğer sürümler reddedilir.
5. `output/HoleDweller-TR-Android-0.2.0-alpha.6.apk` dosyasını Android cihazınıza kopyalayıp yükleyin.

1. 简体中文 · 2. English · 3. Português · 4. Русский · 5. Español · 6. Deutsch · 7. 日本語 · 8. Français · 9. 한국어 · 10. Türkçe

Windows, PowerShell 5.1+, ilk çalıştırma için internet ve en az 2 GB boş alan gerekir. Ana hedef Android ARM64’tür; emülatör denemeleri için x86_64 de bulunur. Eski cihazlar ve 16 KB bellek sayfaları için ek test gerekir. `127.0.0.1:7897` proxy’si algılanır; başka bir proxy için `HD_ANDROID_PROXY` kullanılabilir. Tekrar indirmemek için `tools` ve `.local/runner-2024.14.apk` dosyalarını koruyun.

## Dokunmatik kontroller

| Girdi | İşlev |
| --- | --- |
| Sahneye dokunma | Sol tıklama |
| Oklar / BOŞLUK | Yön / özgün boşluk tuşu işlevi |
| Yukarı okunun yanındaki Q / E | Son dokunma konumunda sol / sağ düğme |
| Sağ kilit | Sağ tıklama modunu açıp kapatır |
| Orta tık / orta kilit | Orta düğme / sürekli mod |
| Tekerlek + / - | Yukarı / aşağı kaydırma; tekrar için basılı tutun |
| Menü / Ger / Tuşlar | Ayarlar / ekranı doldurma / kontrolleri gösterme |
| Geri | Başlık ekranına dönmek için basılı tutun; başlıkta basılı tutmak oyunu kapatır |

Menüde 1×–4× iç çözünürlük, otomatik ölçek, 60/120, ses düzeyi ve yerel MOD değişiklikleri için sahneyi yeniden yükleme bulunur. 120 seçeneği gerçek 120 Hz’i garanti etmez. F11/F12 onay gerektirir. Kayıt silmek için onaydan sonra basılı tutmanız gerekir; bırakmak iptal eder. Android’de Steam Workshop’a yükleme kullanılamaz.

## Çeviri, testler ve güncelleme

Çeviriler bağlam, karakter üslubu ve oyun mekanikleri dikkate alınarak hazırlanıp düzenlendi; otomatik çeviri hizmeti kullanılmadı. İlk 1.000 kayıt GPT’nin High ayarından alındı, son 464 kayıt doğrudan Codex ile çevrildi. Ana dili konuşan kişilerce bağımsız satır satır inceleme henüz yapılmadı. Karakter adları korunur; görsellere gömülü yazılar özgün dilde kalabilir. Eksik veya biçimi bozuk katalog derlemeyi durdurur.

Zaria’nın sahil olayındaki kilitlenme düzeltmesi, alpha.4 sürümünde Lenovo TB-Q706F / Android 12 ile doğrulandı. Bu, alpha.6’nın her dilde baştan sona test edildiği anlamına gelmez. İlgili sürümün test raporuna bakın. Hata bildirirken dil, sürüm, cihaz, Android sürümü ve adımları yazın. `Collect-Crash-Logs.cmd`, USB üzerinden root olmadan ve kayıtları silmeden günlük toplar. Paylaşmadan önce günlükleri inceleyin.

Güncellerken `.local/个人构建签名.jks` dosyasını koruyun: aynı imza, uygulamayı kaldırmadan güncellemeye izin verir. Her dilin paketi ve kayıtları ayrıdır; otomatik aktarım yoktur. Anahtar, kayıt, kişisel günlük, `data.win` veya oyunun tamamını içeren APK yayımlamayın. `locales/tr.game.json` için düzeltme önerirken ID, bağlam ve gerekçe ekleyin. Yeni oyun sürümleri yeniden doğrulama ve uyarlama gerektirir.

## Araçlar, yazı tipi ve lisanslar

| Bileşen | Sürüm ve kaynak |
| --- | --- |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| Android SDK / ADB | [Build Tools 35.0.0](https://developer.android.com/tools/releases/build-tools) · [Platform Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools) |
| Java | [Eclipse Temurin 8u504](https://adoptium.net/) |
| Python | [3.13.7](https://www.python.org/downloads/release/python-3137/) |
| GameMaker | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), 2024.14, `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| Fusion Pixel | [2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px, OFL |
| 7-Zip | [24.08](https://www.7-zip.org/) · [GitHub](https://github.com/ip7z/7zip) |

Türkçe Fusion Pixel latin kullanır; Japonca ve Korece için ayrı sürümler seçilmiştir. Lisanslar `licenses` içindedir. Yeni kod MIT’dir; oyun, çalışma ortamı ve üçüncü taraf bileşenler kendi haklarını korur. Açık oluşturucu oyun veya tam APK içermez. [Hatalar ve öneriler](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues).
