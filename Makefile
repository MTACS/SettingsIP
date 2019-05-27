include $(THEOS)/makefiles/common.mk

THEOS_DEVICE_IP = 10.0.0.151

TWEAK_NAME = SettingsIP
SettingsIP_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"
SUBPROJECTS += sipprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
