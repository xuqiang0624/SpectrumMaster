#!/usr/bin/env bash
# ============================================================
#  把终端提示符里的中文用户名换成一个英文别名（只改「显示」）
#  不改 Windows 账户名、不改 HOME、不碰 .gitconfig
#
#  用法（在 UCRT64 / Git Bash 里执行一次）：
#      bash scripts/setup_prompt.sh              # 显示 xuqiang
#      bash scripts/setup_prompt.sh xq           # 自定义别名
#      source ~/.bashrc                         # 立即生效（或重开终端）
#  还原：删掉 .bashrc 里 BEGIN/END 两块注释之间的内容，
#        或用备份文件 ~/.bashrc.qt28.bak 覆盖回去。
# ============================================================
set -eu

ALIAS="${1:-xuqiang}"
RC="$HOME/.bashrc"
BEGIN="# >>> qt28 prompt BEGIN >>>"
END="# <<< qt28 prompt END <<<"

# 参数只允许字母数字和短横线，避免破坏 PS1
case "$ALIAS" in
  *[!A-Za-z0-9_-]*) echo "[ERROR] 别名只能用英文字母、数字、- 或 _" >&2; exit 1 ;;
esac

[ -f "$RC" ] || : > "$RC"

if grep -q "$BEGIN" "$RC"; then
  echo "已存在自定义提示符，先移除旧块（幂等，不会重复叠加）"
else
  cp -f "$RC" "$RC.qt28.bak"
  echo "已备份原配置 -> $RC.qt28.bak"
fi

# 移除旧的自定义块（用前缀匹配，兼容 CRLF 行尾）
# 生成到同目录临时文件再 mv 覆盖，不调用删除命令
TMP="$RC.qt28.tmp"
awk -v b="$BEGIN" -v e="$END" '
  index($0, b) == 1 { skip = 1; next }
  index($0, e) == 1 { skip = 0; next }
  !skip { print }
' "$RC" > "$TMP"
mv -f "$TMP" "$RC"

# 保证文件末尾有换行，再追加
if [ -s "$RC" ] && [ "$(tail -c 1 "$RC" | wc -l)" -eq 0 ]; then
  printf '\n' >> "$RC"
fi

cat >> "$RC" <<'PROMPT_BLOCK'
# >>> qt28 prompt BEGIN >>>
# 自定义提示符：把 Windows 中文用户名换成英文别名，并始终显示当前目录
# 只影响显示，不改动账户、HOME 或 Git 配置；删掉本块即可还原
PS1='\[\e[32m\]__ALIAS__@qt28\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ '
# <<< qt28 prompt END <<<
PROMPT_BLOCK

# 只替换刚追加那一处占位符
sed -i "s/__ALIAS__/$ALIAS/" "$RC"

echo
echo "[OK] 提示符别名已设为: $ALIAS"
echo "     当前 HOME: $HOME"
echo "     配置文件 : $RC"
echo "现在执行下面这条让它立即生效（或重开一个终端窗口）："
echo "     source ~/.bashrc"
echo
echo "想让终端一打开就在工程目录：双击 scripts/open_here.bat"
