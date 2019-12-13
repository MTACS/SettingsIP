include $(THEOS)/makefiles/common.mk

#THEOS_DEVICE_IP = 10.0.0.151

export THEOS_PLATFORM_SDK_ROOT=$(THEOS)/sdks/iPhoneOS11.2.sdk
ARCHS = armv7 arm64 arm64e

FINALPACKAGE=1
DEBUG=0
GO_EASY_ON_ME=1

TWEAK_NAME = SettingsIP
SettingsIP_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"
SUBPROJECTS += sipprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
