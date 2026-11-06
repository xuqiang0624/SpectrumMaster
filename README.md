# SpectrumMaster · D1 工程骨架

> Qt 6.11.2 + MinGW 13.1 + CMake/Ninja。这个目录是**工程文件夹**（不是单个文件），
> 28 天的所有练习都往这里长，不要另建零散 demo。

## 已就绪的内容
- `CMakeLists.txt`：find_package 验证 Widgets / Network / SerialPort / Charts / PrintSupport 五个模块，AUTOMOC 已开
- `app/main.cpp`：Hello Qt 窗口 + 打印 Qt 版本/C++ 标准 + Device 多态演示
- `device/Device.h`、`TcpDevice.h/.cpp`：抽象接口 + 派生类（D15 换成真实 socket）
- `worker/ widgets/ thirdparty/ docs/ scripts/ tests/ examples/`：占位目录，按计划逐步填

## 编译运行
```bash
# 一次性配置（PATH 里要有 Qt bin / MinGW bin / CMake / Ninja）
cmake -S . -B build -G Ninja \
      -DCMAKE_PREFIX_PATH=D:/Qt/6.11.2/mingw_64 -DCMAKE_BUILD_TYPE=Release
cmake --build build
build/SpectrumMaster.exe          # 双击运行，会看到一个窗口
```
也可以直接双击 `scripts/configure.bat`（已写好 PATH 与命令）。

命令行自检（不弹窗、打印结果后退出）：
```bash
# Git Bash
QT28_SELFTEST=1 QT_QPA_PLATFORM=offscreen QT_FORCE_STDERR_LOGGING=1 build/SpectrumMaster.exe
```
Windows 的 cmd 写法：
```bat
set QT28_SELFTEST=1
set QT_QPA_PLATFORM=offscreen
set QT_FORCE_STDERR_LOGGING=1
build\SpectrumMaster.exe
```
自检时若出现 `Cannot find font directory` 或 `propagateSizeHints` 提示，是 offscreen 虚拟平台的正常信息，双击正常运行不会出现。

## 前置：安装 Git for Windows
本机系统**尚未安装 Git**（PowerShell / cmd 里 `git` 不可用），只有 WorkBuddy 内置终端带便携版，
它能帮我建仓库、做首次提交，但你在自己的命令行里用不了。
先到 https://git-scm.com/download/win 下载 **Git for Windows 64-bit**，一路默认安装
（保留「把 git 加入 PATH」的默认选项），装完**重新打开**命令行敲 `git --version` 验证。
仓库和首次提交都在 `.git` 目录里，装完照样能 `git log` 看到，不用重做。

## 推送到 GitHub
远程仓库已关联好：`origin -> https://github.com/xuqiang0624/SpectrumMaster.git`。
以后提交完代码，双击 `scripts/push.bat`，或在命令行执行：
```bash
git push
```
**首次**推送会弹出浏览器让你登录 GitHub 授权（Git for Windows 自带凭据管理器），授权后自动完成，
不需要手动造令牌；之后直接 `git push` 即可。若弹窗没出现，可在 GitHub →
Settings → Developer settings → Personal access tokens 生成一个勾 `repo` 的 token，
推送时用户名填 GitHub 账号、密码粘贴 token。

## Git 身份（第一次 commit 前必做）
全局身份要用**你自己的**姓名和邮箱（建议与 Gitee/GitHub 账号邮箱一致），
先改 `scripts/setup_git.bat` 里的 `YOUR_NAME` / `YOUR_EMAIL` 再双击，或手动执行：
```bash
git config --global user.name  "你的名字"
git config --global user.email "你的邮箱@example.com"
git config --global --list            # 检查
```
- `--global` 对这台电脑所有仓库生效；不加 `--global`（在仓库目录里执行）只对当前仓库生效，**仓库级优先于全局**。
- 本仓库的首次提交是用临时身份 `-c` 参数生成的，**config 里没有留下任何覆盖**，你配好全局后，之后的提交自动使用真实身份。
- 想把首次提交的作者也改成真实身份：`git commit --amend --reset-author --no-edit`。

## D1 验收
- [ ] `cmake` 配置与编译通过，窗口能显示
- [ ] 自检输出 `Qt runtime: 6.11.2`
- [ ] Git 身份已配置，`git log` 里能看到第一次提交
- [ ] 能说清：为什么 `Device` 的析构要 virtual、AUTOMOC 解决什么问题
