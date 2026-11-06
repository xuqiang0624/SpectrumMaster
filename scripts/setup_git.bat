@echo off
chcp 65001 >nul
REM === Step 1: edit THIS file, replace YOUR_NAME / YOUR_EMAIL with your own ===
REM === Step 2: double-click it again. Global Git identity is then ready. ===
git config --global user.name  "YOUR_NAME"
git config --global user.email "YOUR_EMAIL"
echo.
echo --- current global identity ---
git config --global --get user.name
git config --global --get user.email
echo.
echo If it still shows YOUR_NAME / YOUR_EMAIL, edit this file first.
pause
