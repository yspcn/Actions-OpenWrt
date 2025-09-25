#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#git clone https://github.com/messense/aliyundrive-webdav package/messense
git clone https://github.com/gdy666/luci-app-lucky package/lucky
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone --depth=1 https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale
rm -f feeds/packages/net/tailscale/Makefile
wget -P feeds/packages/net/tailscale https://github.com/asvow/neo-addon/raw/refs/heads/main/tailscale/Makefile
# sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
git clone --depth=1 https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone --depth=1 https://github.com/kenzok8/small package/small
