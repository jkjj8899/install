#!/bin/bash
# 检测系统版本，只支持 CentOS 7 / 8

echo "🔍 检测系统环境..."

if [[ -f /etc/centos-release ]]; then
    version=$(rpm -q --queryformat '%{VERSION}' centos-release)
    if [[ "$version" == "7" || "$version" == "8" ]]; then
        echo "✅ 检测通过：当前为 CentOS $version"
    else
        echo "❌ 不支持的 CentOS 版本：$version，仅支持 CentOS 7 和 8"
        exit 1
    fi
else
    echo "❌ 非 CentOS 系统，安装终止"
    exit 1
fi
