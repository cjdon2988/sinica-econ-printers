#!/bin/bash
# 中研院經濟所印表機設定腳本範本
# 使用方式:Claude 依使用者的回答,把底下 ADD / RENAME / REMOVE 區塊填好,存成一支一次性腳本,
# 請使用者在終端機執行一次(輸入一次 sudo 密碼)。執行完會自動刪除自己。
# 這支腳本只改印表機設定,不碰網路、電源、Tailscale 或其他系統設定。

set -u

# 預設雙面:one-sided(單面)、two-sided-long-edge(長邊翻頁)、two-sided-short-edge(短邊翻頁)
DUPLEX="two-sided-long-edge"

# 新增或更新一台。參數:佇列名、顯示名稱、連線網址
add() {
  sudo lpadmin -p "$1" -D "$2" -E -v "$3" -m everywhere -o sides="$DUPLEX" \
    && echo "已設定:$2" || echo "失敗:$2($1)"
}

# 只改名稱與預設雙面(既有印表機)。參數:佇列名、新的顯示名稱
rename() {
  sudo lpadmin -p "$1" -D "$2" -o sides="$DUPLEX" \
    && echo "已更新:$2" || echo "失敗:$1"
}

# 移除一台(使用者明確要求才放進來)。參數:佇列名
remove() {
  sudo lpadmin -x "$1" && echo "已移除:$1" || echo "失敗:$1"
}

# ===== ADD(Claude 填入,例)=====
# add ipp_172_22_18_61  "大黑一"  "ipp://172.22.18.61/ipp/print"
# add ipp_172_22_18_111 "C棟2F大黑影印機" "ipp://172.22.18.111/"

# ===== RENAME(Claude 填入)=====

# ===== REMOVE(Claude 填入)=====

echo "---- 目前印表機 ----"
lpstat -p -d

rm "$0"
