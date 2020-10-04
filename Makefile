include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ustb
PKG_VERSION=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ustb
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=3. Applications
    TITLE:=USTB for LuCI
    PKGARCH:=all
endef

define Package/luci-app-ustb/description
    This package contains LuCI configuration pages for USTB.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-njitclient/install
    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_DIR) $(1)/usr/share/USTB
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller

    $(INSTALL_CONF) ./root/etc/config/ustb $(1)/etc/config/ustb
    $(INSTALL_BIN) ./root/etc/init.d/ustb $(1)/etc/init.d/ustb
    $(INSTALL_BIN) ./root/usr/share/USTB/link.sh $(1)/usr/share/USTB/link.sh
    $(INSTALL_DATA) ./luasrc/model/cbi/ustb.lua $(1)/usr/lib/lua/luci/model/cbi/ustb.lua
    $(INSTALL_DATA) ./luasrc/model/cbi/ustblog.lua $(1)/usr/lib/lua/luci/model/cbi/ustblog.lua
    $(INSTALL_DATA) ./luasrc/controller/ustb.lua $(1)/usr/lib/lua/luci/controller/ustb.lua
endef

$(eval $(call BuildPackage,luci-app-ustb))