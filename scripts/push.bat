@echo off
chcp 65001 >nul
cd /d D:\Qt\qt28\SpectrumMaster
echo Pushing to GitHub: https://github.com/xuqiang0624/SpectrumMaster
echo A browser window may open for GitHub sign-in. Authorize it, then come back here.
echo.
git push -u origin main
if errorlevel 1 (
  echo.
  echo [X] Push failed. Read the message above.
  echo     If a sign-in window did not appear, see README for the token fallback.
) else (
  echo.
  echo [OK] Pushed. Open: https://github.com/xuqiang0624/SpectrumMaster
)
pause
