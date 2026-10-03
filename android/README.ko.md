# Hole Dweller Android APK 빌더

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**프로젝트 버전: 0.2.0-alpha.6. 지원 게임: 원본 파일 검증이 가능한 Steam Windows r44.** 본인이 구매한 게임으로 Windows에서 APK를 만드는 실험용 도구입니다. GameMaker의 Android 네이티브 실행 환경에서 VM 코드를 실행합니다. 공식 이식판은 아닙니다.

## APK 만들기

1. [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases)에서 빌더의 `.7z`를 받고, 쓰기 가능한 Windows 폴더에 모두 압축 해제합니다. 게임 설치 폴더와 다른 위치를 사용하세요.
2. **Build-APK.cmd**를 실행하고 **9. 한국어**를 선택합니다.
3. 처음 실행하면 없는 포터블 도구 약 144 MB와 Android 실행 환경 약 32 MB를 자동으로 받고 SHA256을 확인합니다. Windows 자동 시작은 설정하지 않습니다.
4. `data.win`이 있는 Hole Dweller 폴더를 선택합니다. 지원되는 r44 원본이나 `data.win.zhCN.original` 백업이 필요합니다. 다른 버전은 거부됩니다.
5. 완료 후 `output/HoleDweller-KO-Android-0.2.0-alpha.6.apk`를 Android 기기로 복사해 설치합니다.

1. 简体中文 · 2. English · 3. Português · 4. Русский · 5. Español · 6. Deutsch · 7. 日本語 · 8. Français · 9. 한국어 · 10. Türkçe

Windows, PowerShell 5.1 이상, 첫 실행 시 인터넷, 최소 2 GB 여유 공간이 필요합니다. 주요 대상은 Android ARM64이며 에뮬레이터 시험용 x86_64도 포함합니다. 구형 기기와 16 KB 메모리 페이지 환경은 추가 검증이 필요합니다. `127.0.0.1:7897` 프록시를 자동 감지하며, 다른 프록시는 `HD_ANDROID_PROXY`로 지정할 수 있습니다. 재다운로드를 피하려면 `tools`와 `.local/runner-2024.14.apk`를 보관하세요.

## 터치 조작

| 입력 | 기능 |
| --- | --- |
| 화면 터치 | 마우스 왼쪽 클릭 |
| 방향 버튼 / 스페이스 | 방향 입력 / 원래 스페이스 기능 |
| 위 버튼 옆 Q / E | 마지막 터치 위치에서 왼쪽 / 오른쪽 클릭 |
| 오른쪽 고정 | 오른쪽 클릭 모드 전환 |
| 가운데 클릭 / 가운데 고정 | 가운데 버튼 / 지속 모드 |
| 휠 + / - | 위 / 아래 스크롤, 길게 누르면 반복 |
| 메뉴 / 늘리기 / 버튼 | 설정 / 화면 채우기 / 조작 표시 |
| 뒤로 | 길게 눌러 제목 화면으로, 제목 화면에서 길게 눌러 종료 |

메뉴에는 내부 해상도 1~4배, 자동 배율, 60/120, 효과음 볼륨, 로컬 MOD용 장면 다시 불러오기가 있습니다. 120 설정이 실제 120 Hz를 보장하지는 않습니다. F11/F12 기능은 확인이 필요합니다. 저장 삭제는 확인 후 길게 누르기로 실행하고 손을 떼면 취소합니다. Android에서 Steam Workshop 업로드는 지원하지 않습니다.

## 번역, 검증 및 업데이트

번역은 GPT의 High에서 맥락, 인물 말투, 게임 시스템을 고려해 작성하고 다듬었습니다. 자동 번역 서비스는 사용하지 않았습니다. 원어민의 독립적인 전체 문장 검수는 아직 없습니다. 인물 이름은 유지하며 이미지에 포함된 글자는 원문으로 남을 수 있습니다. 번역 누락이나 형식 오류가 있으면 빌드를 중단합니다.

Zaria 해변 이벤트 멈춤 수정은 alpha.4를 Lenovo TB-Q706F / Android 12에서 확인했습니다. alpha.6의 모든 언어로 전체 게임을 검증했다는 뜻은 아닙니다. 해당 릴리스의 검증 기록을 참고하세요. 오류 제보 시 언어, 버전, 기기, Android 버전과 재현 단계를 적어 주세요. `Collect-Crash-Logs.cmd`는 USB로 로그를 수집하며 root나 저장 삭제가 필요 없습니다. 공개하기 전에 로그 내용을 확인하세요.

업데이트 시 `.local/个人构建签名.jks`를 보관하세요. 같은 서명이면 앱을 삭제하지 않고 업데이트할 수 있습니다. 언어별 패키지와 저장은 독립적이며 자동 이전은 없습니다. 키, 저장 파일, 개인 로그, `data.win`, 게임 전체가 든 APK를 공개하지 마세요. 번역 수정은 `locales/ko.game.json`의 ID, 문맥과 이유를 함께 제안할 수 있습니다. 게임 새 버전은 다시 검증하고 수정해야 합니다.

## 도구, 글꼴 및 라이선스

| 항목 | 버전 및 배포처 |
| --- | --- |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| Android SDK / ADB | [Build Tools 35.0.0](https://developer.android.com/tools/releases/build-tools) · [Platform Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools) |
| Java | [Eclipse Temurin 8u504](https://adoptium.net/) |
| Python | [3.13.7](https://www.python.org/downloads/release/python-3137/) |
| GameMaker | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), 2024.14, `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| Fusion Pixel | [2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px, OFL |
| 7-Zip | [24.08](https://www.7-zip.org/) · [GitHub](https://github.com/ip7z/7zip) |

한국어는 Fusion Pixel ko를 사용합니다. 라이선스는 `licenses`에 있습니다. 새 코드는 MIT이며 게임, 실행 환경, 외부 도구에는 각각의 권리가 적용됩니다. 공개 빌더에는 게임 본체나 완성 APK가 없습니다. [문제 및 제안](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues).
