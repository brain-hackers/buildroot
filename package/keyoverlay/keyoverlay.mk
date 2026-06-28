################################################################################
#
# keyoverlay
#
################################################################################

KEYOVERLAY_VERSION = 1.0.0
KEYOVERLAY_SITE = $(call github,tslmy,sharp-brain-keyboard-overlay,v$(KEYOVERLAY_VERSION))
KEYOVERLAY_LICENSE = MIT
KEYOVERLAY_LICENSE_FILES = LICENSE

# Console/framebuffer only; the X11 backend is opt-in and not needed on the
# bare TUI Buildroot target.
define KEYOVERLAY_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) WITHOUT_X11=1 \
		CFLAGS="$(TARGET_CFLAGS)" -C $(@D)
endef

define KEYOVERLAY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/keyoverlay $(TARGET_DIR)/usr/bin/keyoverlay
	$(INSTALL) -D -m 0755 $(@D)/init/S95keyoverlay $(TARGET_DIR)/etc/init.d/S95keyoverlay
endef

$(eval $(generic-package))
