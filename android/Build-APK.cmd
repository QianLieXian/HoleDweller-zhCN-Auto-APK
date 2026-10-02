@echo off

chcp 65001 >nul

cd /d "%~dp0"

echo Hole Dweller Android APK Builder

echo.

echo 1. 打包中文版 / Build Chinese APK

echo 2. Build English APK

echo.

echo 首次运行会自动下载便携打包环境和安卓运行器，不设置开机自启。

echo First run automatically downloads portable build tools and the Android runner.

echo No startup tasks or system-wide installation are added.

choice /c 12 /n /m "请选择 / Choose [1/2]: "

if errorlevel 2 (set "HD_BUILD_LANG=en") else (set "HD_BUILD_LANG=zh")

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build-APK.ps1" -Language %HD_BUILD_LANG%

set "HD_BUILD_EXIT=%errorlevel%"

echo.

pause

exit /b %HD_BUILD_EXIT%

