# Hole Dweller — générateur d’APK Android

[简体中文](README.md) · [English](README.en.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [한국어](README.ko.md) · [Türkçe](README.tr.md)

**Version du projet : 0.2.0-alpha.6. Jeu pris en charge : Steam Windows r44, avec vérification du fichier d’origine.** Cet outil expérimental crée un APK local à partir de votre propre exemplaire. Le code VM fonctionne dans un runtime natif GameMaker pour Android. Ce port n’est pas officiel.

## Créer votre APK

1. Téléchargez l’archive `.7z` du générateur depuis [Releases](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/releases). Extrayez-la entièrement dans un dossier Windows accessible en écriture, hors du dossier du jeu.
2. Ouvrez **Build-APK.cmd** et choisissez **8. Français**.
3. Au premier lancement, les outils portables manquants sont téléchargés automatiquement : environ 144 Mo, puis 32 Mo pour le runtime Android. Leurs empreintes SHA256 sont vérifiées. Aucun démarrage automatique de Windows n’est configuré.
4. Sélectionnez le dossier Hole Dweller contenant `data.win`. Il faut l’original r44 compatible ou sa sauvegarde `data.win.zhCN.original`. Les autres versions sont refusées.
5. Copiez `output/HoleDweller-FR-Android-0.2.0-alpha.6.apk` sur votre appareil Android et installez-le.

1. 简体中文 · 2. English · 3. Português · 4. Русский · 5. Español · 6. Deutsch · 7. 日本語 · 8. Français · 9. 한국어 · 10. Türkçe

Prévoyez Windows, PowerShell 5.1+, une connexion au premier lancement et au moins 2 Go libres. La cible principale est Android ARM64 ; x86_64 est inclus pour les essais sur émulateur. Les anciens appareils et les pages mémoire de 16 Ko demandent davantage de tests. Le proxy `127.0.0.1:7897` est détecté ; `HD_ANDROID_PROXY` permet d’en indiquer un autre. Conservez `tools` et `.local/runner-2024.14.apk` pour éviter de nouveaux téléchargements.

## Commandes tactiles

| Commande | Action |
| --- | --- |
| Toucher la scène | Clic gauche |
| Flèches / ESPACE | Direction / action d’origine de la barre d’espace |
| Q / E près de la flèche haut | Bouton gauche / droit à la dernière position touchée |
| Verrou droit | Alterne le mode clic droit |
| Clic milieu / verrou milieu | Bouton central / mode persistant |
| Molette + / - | Défiler vers le haut / bas ; maintenir pour répéter |
| Menu / Étirer / Touches | Réglages / remplir l’écran / afficher les commandes |
| Retour | Maintenir pour revenir au titre ; au titre, maintenir pour quitter |

Le menu propose une résolution interne 1×–4×, une sélection automatique, 60/120, le volume et le rechargement de scène pour les MOD locaux. L’option 120 ne garantit pas 120 Hz réels. F11/F12 nécessitent une confirmation. Effacer une sauvegarde demande confirmation et maintien ; relâcher annule. La publication dans Steam Workshop est indisponible sur Android.

## Traduction, tests et mises à jour

Les traductions ont été rédigées et révisées selon le contexte, les personnages et les mécaniques, sans service de traduction automatique. Les 1 000 premières entrées viennent de GPT en High ; les 464 dernières ont été traduites directement avec Codex. Une relecture indépendante de toutes les lignes par des locuteurs natifs reste à faire. Les noms sont conservés ; les textes intégrés aux images peuvent rester dans leur langue d’origine. Un catalogue incomplet ou mal formaté bloque la compilation.

Le correctif du blocage sur la plage avec Zaria a été confirmé dans alpha.4 sur Lenovo TB-Q706F / Android 12. Cela ne prouve pas une partie complète d’alpha.6 dans chaque langue. Consultez le rapport du lancement. Pour signaler un problème, indiquez langue, version, appareil, Android et étapes. `Collect-Crash-Logs.cmd` récupère les journaux par USB sans root ni suppression des sauvegardes ; vérifiez-les avant publication.

Lors d’une mise à jour, conservez `.local/个人构建签名.jks` : la même signature permet une installation par-dessus l’application existante. Chaque langue a son paquet et ses sauvegardes propres, sans migration automatique. Ne publiez pas les clés, sauvegardes, journaux personnels, `data.win` ou APK contenant le jeu complet. Proposez des corrections dans `locales/fr.game.json` avec l’ID, le contexte et une justification. Toute nouvelle version du jeu demande une nouvelle vérification et adaptation.

## Outils, police et licences

| Composant | Version et source |
| --- | --- |
| UndertaleModTool | [0.9.2.0](https://github.com/UnderminersTeam/UndertaleModTool/releases/tag/0.9.2.0) |
| Apktool | [2.12.1](https://github.com/iBotPeaches/Apktool/releases/tag/v2.12.1) |
| Android SDK / ADB | [Build Tools 35.0.0](https://developer.android.com/tools/releases/build-tools) · [Platform Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools) |
| Java | [Eclipse Temurin 8u504](https://adoptium.net/) |
| Python | [3.13.7](https://www.python.org/downloads/release/python-3137/) |
| GameMaker | [GameMaker-Mobiler](https://github.com/znm2500/GameMaker-Mobiler), 2024.14, `6a23adc1d4e71c238456568df18f85cc7b44caa9` |
| Fusion Pixel | [2026.09.25](https://github.com/TakWolf/fusion-pixel-font/releases/tag/2026.09.25), 12px, OFL |
| 7-Zip | [24.08](https://www.7-zip.org/) · [GitHub](https://github.com/ip7z/7zip) |

Le français utilise Fusion Pixel latin ; le japonais et le coréen ont leurs variantes. Les licences sont dans `licenses`. Le nouveau code est sous MIT ; le jeu, le runtime et les composants tiers conservent leurs droits respectifs. Le générateur public ne contient ni jeu ni APK complets. [Problèmes et suggestions](https://github.com/QianLieXian/HoleDweller-zhCN-Auto-APK/issues).
