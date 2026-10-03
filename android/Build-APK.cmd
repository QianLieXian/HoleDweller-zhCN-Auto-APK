@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Hole Dweller APK Builder
echo 1. 简体中文
echo 2. English
echo 3. Português
echo 4. Русский
echo 5. Español
echo 6. Deutsch
echo 7. 日本語
echo 8. Français
echo 9. 한국어
echo 10. Türkçe
echo.
echo 首次运行会自动下载便携工具和安卓运行器，不设置开机自启。
echo First run downloads portable tools and the Android runner. No startup tasks.
set "HD_BUILD_CHOICE="
set /p "HD_BUILD_CHOICE=Select language [1-10]: "
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build-APK.ps1" -MenuChoice
set "HD_BUILD_EXIT=%errorlevel%"
echo.
pause
exit /b %HD_BUILD_EXIT%
