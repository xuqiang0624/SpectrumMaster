@echo off
chcp 65001 >nul
where git >nul 2>nul
if errorlevel 1 (
  echo [X] Git not found in PATH.
  echo     Install Git for Windows first: https://git-scm.com/download/win
  echo     Keep the default install options, then REOPEN this window and run again.
  pause
  exit /b 1
)
echo Git found:
git --version
echo.
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
