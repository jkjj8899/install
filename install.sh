#!/bin/bash
set -e

echo "🔍 开始系统检测..."

# 获取系统版本
version=""
if grep -qi centos /etc/os-release; then
    version=$(grep -oP '(?<=VERSION_ID="?)\d+' /etc/os-release | head -1)
    echo "✅ 检测到系统为 CentOS $version"
else
    echo "⚠️ 未检测到 CentOS 系统"
fi

# 系统版本交互确认
echo ""
read -rp "👉 是否继续执行安装脚本？(y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "⛔ 已取消执行，退出脚本。"
    exit 0
fi

echo ""
echo "🧩 开始检测宝塔面板是否已安装..."

# 检测宝塔是否已安装
if [ -d "/www/server/panel" ]; then
    echo "✅ 检测到宝塔已安装：/www/server/panel 存在"
else
    echo "⚠️ 未检测到宝塔面板"
    read -rp "👉 是否现在安装宝塔？(y/n): " bt_confirm
    if [[ "$bt_confirm" == "y" || "$bt_confirm" == "Y" ]]; then
        echo "🚀 开始安装宝塔..."
        yum install -y wget
        wget -O install.sh http://bt.ng-os.com/install/install_6.0.sh
        bash install.sh
    else
        echo "⛔ 跳过宝塔安装"
    fi
fi

echo ""
echo "🎉 安装流程完成！后续你可以继续添加 LNMP、项目部署等步骤。"
