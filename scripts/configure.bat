@echo off
chcp 65001 >nul
set PATH=D:\Qt\6.11.2\mingw_64\bin;D:\Qt\Tools\mingw1310_64\bin;D:\Qt\Tools\CMake_64\bin;D:\Qt\Tools\Ninja;%PATH%
cd /d D:\Qt\qt28\SpectrumMaster
cmake -S . -B build -G Ninja -DCMAKE_PREFIX_PATH=D:\Qt\6.11.2\mingw_64 -DCMAKE_BUILD_TYPE=Release
if errorlevel 1 (echo [X] CMake configure failed & pause & exit /b 1)
cmake --build build
if errorlevel 1 (echo [X] Build failed & pause & exit /b 1)
echo [OK] build\SpectrumMaster.exe
pause
