# Hole Dweller — Criador de APK Android

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**Versão do projeto: 0.2.0-alpha.6. Jogo compatível: Steam Windows r44, com verificação do arquivo original.** Esta ferramenta experimental cria um APK local a partir da sua própria cópia do jogo. O código VM roda em um runtime nativo do GameMaker para Android. Não é uma versão oficial.

## Criar seu APK

1. Baixe o arquivo `.7z` do criador em [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases) e extraia tudo para uma pasta gravável no Windows, fora da pasta do jogo.
2. Abra **Build-APK.cmd** e escolha **3. Português**. O português do jogo é brasileiro.
3. Na primeira execução, as ferramentas portáteis ausentes são baixadas automaticamente: cerca de 144 MB, mais 32 MB para o runtime Android. Os arquivos são verificados por SHA256. Nada é configurado para iniciar com o Windows.
4. Selecione sua pasta do Hole Dweller com `data.win`. O arquivo original r44 ou o backup `data.win.zhCN.original` é necessário; outra versão é recusada.
5. Ao terminar, copie `output/HoleDweller-PT-Android-0.2.0-alpha.6.apk` para o Android e instale.

1. 简体中文 · 2. English · 3. Português · 4. Русский · 5. Español · 6. Deutsch · 7. 日本語 · 8. Français · 9. 한국어 · 10. Türkçe

Use Windows com PowerShell 5.1+, internet na primeira execução e pelo menos 2 GB livres. O alvo principal é Android ARM64; x86_64 serve para testes em emulador. Aparelhos antigos e páginas de memória de 16 KB ainda precisam de validação. O proxy local `127.0.0.1:7897` é detectado; `HD_ANDROID_PROXY` permite indicar outro. Guarde `tools` e `.local/runner-2024.14.apk` para evitar novos downloads.

## Controles

| Entrada | Ação |
| --- | --- |
| Toque na cena | Clique esquerdo |
| Setas / ESPAÇO | Direção e ação original da barra de espaço |
| Q / E ao lado da seta para cima | Botão esquerdo / direito na última posição tocada |
| Trava direita | Alterna o modo de clique direito |
| Clique do meio / trava do meio | Clique central / modo central persistente |
| Roda + / Roda - | Rola para cima / baixo; segure para repetir |
| Menu / Esticar / Teclas | Opções / preencher a tela / mostrar controles |
| Voltar | Segure para ir ao título; no título, segure para sair |

O menu inclui resolução interna de 1× a 4×, escala automática, 60/120, volume e recarga da cena para MODs locais. O modo 120 não garante 120 Hz reais. F11/F12 exigem confirmação. Excluir o save exige confirmação e toque prolongado; soltar cancela. Envio ao Steam Workshop não funciona no Android.

## Tradução, testes e atualizações

As traduções foram elaboradas e revisadas com GPT em High, considerando contexto, personagens e mecânicas, sem serviço automático de tradução. Ainda falta revisão independente por falantes nativos. Nomes de personagens permanecem iguais; texto embutido em imagens pode continuar no idioma original. O criador recusa catálogos incompletos ou com formatação inválida.

A correção do travamento na praia com Zaria foi confirmada na alpha.4 em Lenovo TB-Q706F / Android 12. Isso não equivale a uma campanha completa testada em cada idioma da alpha.6. Consulte o relatório de testes da versão. Para relatar problemas, inclua idioma, versão, aparelho, Android e passos; `Collect-Crash-Logs.cmd` coleta logs via USB sem root e sem apagar saves. Revise os logs antes de publicá-los.

Ao atualizar, preserve `.local/个人构建签名.jks`: a mesma assinatura permite atualizar o APK sem desinstalar. Cada idioma usa um pacote e saves separados, sem migração automática. Não publique a chave, saves, logs pessoais, `data.win` ou APKs com o jogo completo. Sugira correções com o ID da entrada em `locales/pt.game.json`, contexto e justificativa. Uma nova versão do jogo precisa de nova verificação e adaptação.

## Ferramentas, fontes e licença

| Componente | Versão e origem |
| --- | --- |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| Android SDK / ADB | [Build Tools 35.0.0](https://developer.android.com/tools/releases/build-tools) · [Platform Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools) |
| Java | [Eclipse Temurin 8u504](https://adoptium.net/) |
| Python | [3.13.7](https://www.python.org/downloads/release/python-3137/) |
| GameMaker | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), 2024.14, `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| Fusion Pixel | [2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px, OFL |
| 7-Zip | [24.08](https://www.7-zip.org/) · [GitHub](https://github.com/ip7z/7zip) |

O português usa Fusion Pixel latin; japonês e coreano usam variantes próprias. Licenças estão em `licenses`. O código novo é MIT; jogo, runtime e componentes terceiros mantêm seus próprios direitos. O criador público não inclui o jogo nem APKs completos. [Problemas e sugestões](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues).
