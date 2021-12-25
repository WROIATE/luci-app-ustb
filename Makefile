include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ustb
PKG_VERSION=3.0
PKG_RELEASE:=2

PKG_MAINTAINER:=WROIATE <j.wroiate@gmail.com>

LUCI_TITLE:=Luci for USTB Net Tools
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+curl

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
