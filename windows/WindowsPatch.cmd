@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Hole Dweller Windows Localization
echo 1. 简体中文
echo 2. English ^(Restore original / 还原英文^)
echo 3. Português
echo 4. Русский
echo 5. Español
echo 6. Deutsch
echo 7. 日本語
echo 8. Français
echo 9. 한국어
echo 10. Türkçe
set "HD_WINDOWS_CHOICE="
set /p "HD_WINDOWS_CHOICE=Select [1-10]: "
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install.ps1"
set "HD_WINDOWS_EXIT=%errorlevel%"
pause
exit /b %HD_WINDOWS_EXIT%
