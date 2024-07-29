$(call TOOLS_INIT, 3.0.14)
$(PKG)_SOURCE:=$(pkg_short)-$($(PKG)_VERSION).tar.gz
$(PKG)_HASH:=eeca035d4dd4e84fc25846d952da6297484afa0650a6f84c682e39df3a4123ca
$(PKG)_SITE:=https://www.openssl.org/source
### WEBSITE:=https://www.openssl.org/source/
### MANPAGE:=https://www.openssl.org/docs/
### CHANGES:=https://www.openssl.org/news/changelog.html
### CVSREPO:=https://github.com/openssl/openssl
### SUPPORT:=fda77

$(PKG)_DESTDIR             := $(FREETZ_BASE_DIR)/$(TOOLS_BUILD_DIR)

#$(PKG)_PKGCONFIG_SHORT       := openssl libcrypto libssl
#$(PKG)_PKGCONFIG_TARGET_DIR  := $($(PKG)_PKGCONFIG_SHORT:%=$($(PKG)_DESTDIR)/lib*/pkgconfig/%.pc)

$(PKG)_LIBRARIES_SHORT       := libcrypto libssl
$(PKG)_LIBRARIES_SOURCE_DIR  := $($(PKG)_LIBRARIES_SHORT:%=$($(PKG)_DIR)/%.a)

# Makefile is regenerated by configure
$(PKG)_PATCH_POST_CMDS += $(RM) Makefile Makefile.bak;
$(PKG)_PATCH_POST_CMDS += ln -s Configure configure;

#$(PKG)_CONFIGURE_OPTIONS += --prefix=$(OPENSSL_HOST_DESTDIR)


$(TOOLS_SOURCE_DOWNLOAD)
$(TOOLS_UNPACKED)
$(TOOLS_CONFIGURED_CONFIGURE)

$($(PKG)_DIR)/.compiled: $($(PKG)_DIR)/.configured
	$(TOOLS_SUBMAKE) -C $(OPENSSL_HOST_DIR) all
	@touch $@

#$($(PKG)_DIR)/.installed: $($(PKG)_DIR)/.compiled
#	$(TOOLS_SUBMAKE) -C $(OPENSSL_HOST_DIR) install_sw
#	@touch $@

#$(pkg)-fixhardcoded:
#	-@$(SED) -i "s!$(TOOLS_HARDCODED_DIR)!$(OPENSSL_HOST_DESTDIR)!g" \
#		$(OPENSSL_HOST_PKGCONFIG_TARGET_DIR)

#$(pkg)-precompiled: $($(PKG)_DIR)/.installed
$(pkg)-precompiled: $($(PKG)_DIR)/.compiled


$(pkg)-clean:
	-$(MAKE) -C $(OPENSSL_HOST_DIR) clean
	-$(RM) $(OPENSSL_HOST_DIR)/.{configured,compiled,installed,fixhardcoded}

$(pkg)-dirclean:
	$(RM) -r $(OPENSSL_HOST_DIR)

$(pkg)-distclean: $(pkg)-dirclean
#	$(RM) -r \
#		$(OPENSSL_HOST_PKGCONFIG_TARGET_DIR) \
#		$(OPENSSL_HOST_DESTDIR)/lib*/libcrypto.* \
#		$(OPENSSL_HOST_DESTDIR)/lib*/libssl.* \
#		$(OPENSSL_HOST_DESTDIR)/lib*/engines-3/ \
#		$(OPENSSL_HOST_DESTDIR)/lib*/ossl-modules/ \
#		$(OPENSSL_HOST_DESTDIR)/include/openssl/

$(TOOLS_FINISH)

