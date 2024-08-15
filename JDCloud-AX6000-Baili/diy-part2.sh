#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/ImmortalWrt/JDC-BaiLi/g' package/base-files/files/bin/config_generate

# Modify default golang
#rm -rf feeds/packages/lang/golang
#git clone --depth=1 -b 23.05 https://github.com/Lienol/openwrt-packages #https://github.com/immortalwrt/packages
#cp -rf openwrt-packages/lang/golang feeds/packages/lang/  && rm -rf openwrt-packages
#sed -i 's/ +libopenssl-legacy//g' package/small/shadowsocksr-libev/Makefile

# tailscale install
mkdir -p package/utils/ucode
wget -P package/utils/ucode/ https://github.com/openwrt/openwrt/raw/openwrt-22.03/package/utils/ucode/Makefile
#git clone --depth=1 -b openwrt-23.05 https://github.com/openwrt/packages packages-temp
#rm -rf feeds/packages/net/tailscale && cp -rf packages-temp/net/tailscale feeds/packages/net/
#rm -rf packages-temp
#rm -f feeds/packages/net/tailscale/Makefile
#wget -P feeds/packages/net/tailscale/ https://github.com/openwrt/packages/raw/openwrt-23.05/net/tailscale/Makefile
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
rm -rf package/feeds/luci/luci-app-ipsec-vpnd package/feeds/luci/luci-app-ipsec-vpnserver-manyusers package/openwrt-packages/luci-app-homeproxy

##-----------------Del duplicate packages------------------
rm -rf feeds/packages/net/open-app-filter
##-----------------Add OpenClash dev core------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
##-----------------Delete DDNS's examples-----------------
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
##-----------------Manually set CPU frequency for MT7986A-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="2.0GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo
