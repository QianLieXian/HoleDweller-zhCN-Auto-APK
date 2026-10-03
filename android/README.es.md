# Hole Dweller — creador de APK para Android

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**Versión del proyecto: 0.2.0-alpha.6. Juego compatible: Steam Windows r44, con comprobación del archivo original.** Esta herramienta experimental crea un APK local a partir de tu propia copia. El código VM se ejecuta en un entorno nativo de GameMaker para Android. No es un port oficial.

## Crear el APK

1. Descarga el archivo `.7z` del creador desde [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases) y extráelo completo en una carpeta de Windows con permiso de escritura, fuera de la instalación del juego.
2. Abre **Build-APK.cmd** y elige **5. Español**.
3. La primera ejecución descarga las herramientas portátiles que falten: unos 144 MB, más 32 MB para el entorno Android. Se verifican mediante SHA256. No se añade nada al inicio automático de Windows.
4. Selecciona la carpeta de Hole Dweller que contiene `data.win`. Hace falta el original r44 compatible o su copia `data.win.zhCN.original`; otras versiones se rechazan.
5. Copia `output/HoleDweller-ES-Android-0.2.0-alpha.6.apk` a tu dispositivo Android e instálalo.

1. 简体中文 · 2. English · 3. Português · 4. Русский · 5. Español · 6. Deutsch · 7. 日本語 · 8. Français · 9. 한국어 · 10. Türkçe

Necesitas Windows, PowerShell 5.1+, internet para la primera ejecución y al menos 2 GB libres. El destino principal es Android ARM64; x86_64 se incluye para pruebas en emulador. Los dispositivos antiguos y las páginas de memoria de 16 KB requieren más pruebas. Se detecta el proxy `127.0.0.1:7897`; puedes indicar otro mediante `HD_ANDROID_PROXY`. Conserva `tools` y `.local/runner-2024.14.apk` para evitar nuevas descargas.

## Controles

| Entrada | Acción |
| --- | --- |
| Tocar la escena | Clic izquierdo |
| Flechas / ESPACIO | Dirección / acción original de espacio |
| Q / E junto a la flecha arriba | Botón izquierdo / derecho en la última posición tocada |
| Bloqueo derecho | Alterna el modo de clic derecho |
| Clic central / bloqueo central | Botón central / modo persistente |
| Rueda + / - | Desplazamiento arriba / abajo; mantener para repetir |
| Menú / Estirar / Teclas | Ajustes / llenar la pantalla / mostrar controles |
| Volver | Mantener para ir al título; allí, mantener para salir |

El menú ofrece escala interna 1×–4×, escala automática, 60/120, volumen y recarga de escena para MOD locales. La opción 120 no garantiza 120 Hz reales. F11/F12 requieren confirmación. Borrar la partida exige confirmar y mantener pulsado; soltar cancela. No se puede publicar en Steam Workshop desde Android.

## Traducción, pruebas y actualizaciones

Las traducciones se redactaron y revisaron con GPT en High según el contexto, los personajes y las mecánicas, sin servicios de traducción automática. Falta una revisión independiente de cada línea por hablantes nativos. Los nombres se conservan; los textos incrustados en imágenes pueden seguir en el idioma original. Un catálogo incompleto o con formato incorrecto impide compilar.

La corrección del bloqueo en la playa con Zaria se confirmó en alpha.4, Lenovo TB-Q706F / Android 12. No equivale a una partida completa de alpha.6 en cada idioma. Consulta el informe de pruebas del lanzamiento. Al comunicar errores, incluye idioma, versión, dispositivo, Android y pasos. `Collect-Crash-Logs.cmd` recoge registros por USB sin root ni borrar partidas; revísalos antes de publicarlos.

Al actualizar, conserva `.local/个人构建签名.jks`: la misma firma permite actualizar sin desinstalar. Cada idioma tiene su propio paquete y partidas independientes, sin migración automática. No publiques claves, partidas, registros personales, `data.win` ni APK con el juego completo. Propón cambios en `locales/es.game.json` con el ID, contexto y explicación. Una nueva versión del juego necesita comprobación y adaptación nuevas.

## Herramientas, fuentes y licencias

| Componente | Versión y origen |
| --- | --- |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| Android SDK / ADB | [Build Tools 35.0.0](https://developer.android.com/tools/releases/build-tools) · [Platform Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools) |
| Java | [Eclipse Temurin 8u504](https://adoptium.net/) |
| Python | [3.13.7](https://www.python.org/downloads/release/python-3137/) |
| GameMaker | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), 2024.14, `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| Fusion Pixel | [2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px, OFL |
| 7-Zip | [24.08](https://www.7-zip.org/) · [GitHub](https://github.com/ip7z/7zip) |

El español usa Fusion Pixel latin; japonés y coreano usan variantes propias. Las licencias están en `licenses`. El código nuevo es MIT; el juego, el entorno y los componentes de terceros conservan sus derechos. El creador público no incluye el juego ni APK completos. [Errores y propuestas](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues).
