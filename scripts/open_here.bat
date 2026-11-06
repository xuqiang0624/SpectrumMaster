@echo off
chcp 65001 >nul
REM ============================================================
REM  双击本文件：打开一个「已经在工程目录」的 Git Bash 窗口
REM  以后敲 git status / git push 不用再手动 cd
REM ============================================================
set "PROJ=D:\Qt\qt28\SpectrumMaster"
set "GB=D:\Git\git-bash.exe"

if not exist "%PROJ%\CMakeLists.txt" (
  echo [ERROR] 找不到工程: %PROJ%
  pause
  exit /b 1
)
if not exist "%GB%" set "GB=%ProgramFiles%\Git\git-bash.exe"
if not exist "%GB%" (
  echo [ERROR] 没找到 git-bash.exe。也可以手动打开 cmd 后执行:
  echo         cd /d D:\Qt\qt28\SpectrumMaster
  pause
  exit /b 1
)

echo 正在打开工程终端: %PROJ%
REM /D 让新窗口的工作目录直接就是工程目录；Git Bash 的 /etc/profile 不会强制跳回 ~
start "" /D "%PROJ%" "%GB%"
echo 若窗口里仍显示 ~，手动敲一次: cd /d/Qt/qt28/SpectrumMaster
