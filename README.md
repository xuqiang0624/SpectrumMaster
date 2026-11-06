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

## 环境备忘：Git
Git for Windows 已装在 `D:\Git`（2.56.0），全局身份已配置，GitHub 首次推送也已授权完成。
换电脑重装时：到 https://git-scm.com/download/win 下载 **Git for Windows 64-bit**，一路默认安装
（保留「把 git 加入 PATH」），装完**重新打开**命令行敲 `git --version` 验证；
仓库和提交历史都在 `.git` 目录里，与用哪个 Git 无关，不用重做。

## 推送到 GitHub
远程仓库已关联好：`origin -> https://github.com/xuqiang0624/SpectrumMaster.git`。
以后提交完代码，双击 `scripts/push.bat`，或在命令行执行：
```bash
git push
```
首次推送已完成（浏览器授权 + 凭据已缓存），以后直接 `git push` 即可，不用再登录，
也不需要手动造令牌。换新电脑或凭据失效时若弹窗没出现，可在 GitHub →
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

## 附录：终端里的中文用户名与默认目录（可选）
终端提示符 `未来可期 @//laptop-1n0ae48p/ UCRT64 ~` 拆开看：
`未来可期` 是 **Windows 账户名**，`@//laptop-1n0ae48p/` 是主机名，`UCRT64` 是终端环境，`~` 是当前在家目录。

- **不需要改 Windows 账户名**。工程在 `D:\Qt\qt28\SpectrumMaster`（纯英文路径），
  Qt / CMake / Git 编译都不受中文账户名影响；要避开的只是「把工程放桌面」。
  直接重命名用户文件夹，会让 PATH 里指向 `C:\Users\未来可期` 的项、`.gitconfig`、
  Qt Creator / VS Code 等大量绝对路径配置失效，风险远大于收益。
- **别改 `HOME` 环境变量**。Git 全局身份存在 `C:\Users\未来可期\.gitconfig`，
  改了 HOME 就找不到它，`git commit` 会重新报 "Please tell me who you are"。
- **只想让显示名变英文**（纯外观，最安全）：
  ```bash
  cd /d/Qt/qt28/SpectrumMaster
  bash scripts/setup_prompt.sh          # 别名默认 xuqiang，也可跟一个自定义别名
  source ~/.bashrc                      # 立即生效，或重开终端窗口
  ```
  脚本只往 `~/.bashrc` 追加一段 PS1：会先备份为 `~/.bashrc.qt28.bak`，
  重复执行不会叠加，删掉 `BEGIN/END` 两个标记之间的内容即可还原。
  它不改账户名、不改 HOME、不碰 `.gitconfig`。
- **让终端一打开就在工程目录**：双击 `scripts/open_here.bat`，
  以后不必每次先 `cd /d/Qt/qt28/SpectrumMaster`。当然手动 `cd` 永远有效：
  ```bash
  cd /d/Qt/qt28/SpectrumMaster   # UCRT64 / Git Bash
  cd /d D:\Qt\qt28\SpectrumMaster  # cmd / PowerShell
  ```
