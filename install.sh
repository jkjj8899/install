#!/bin/bash
# 一键安装脚本：支持 CentOS 7/8，自动检测系统和安装宝塔

set -e

echo "🔍 开始系统检测..."

# -----------------------------
# 第一步：检测是否是 CentOS 7 / 8
# -----------------------------
if [[ -f /etc/centos-release ]]; then
    version=$(rpm -q --queryformat '%{VERSION}' centos-release)
    if [[ "$version" == "7" || "$version" == "8" ]]; then
        echo "✅ 当前系统为 CentOS $version"
    else
        echo "❌ 不支持的 CentOS 版本：$version，仅支持 CentOS 7 和 8"
        exit 1
    fi
else
    echo "❌ 非 CentOS 系统，安装终止"
    exit 1
fi

# -----------------------------
# 第二步：检测是否安装宝塔面板
# -----------------------------
echo ""
echo "🧩 正在检测是否已安装宝塔面板..."

if [ -d "/www/server/panel" ]; then
    echo "✅ 宝塔面板已安装"
else
    echo "⚠️  宝塔未安装，是否安装？(y/n)"
    read -p "请输入你的选择：" confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "🚀 开始安装宝塔..."
        yum install -y wget
        wget -O install.sh http://bt.ng-os.com/install/install_6.0.sh && sh install.sh
    else
        echo "⛔ 已取消安装宝塔"
    fi
fi

echo ""
echo "🎉 初始安装流程已完成，后续功能请继续扩展..."
