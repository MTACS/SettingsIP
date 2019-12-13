include $(THEOS)/makefiles/common.mk

ARCHS = armv7 arm64 arm64e

DEBUG=0

TWEAK_NAME = SettingsIP

$(TWEAK_NAME)_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"
SUBPROJECTS += sipprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
