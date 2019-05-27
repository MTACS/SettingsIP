include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SIPPrefs
SIPPrefs_FILES = mtcRootListController.m
SIPPrefs_INSTALL_PATH = /Library/PreferenceBundles
SIPPrefs_FRAMEWORKS = UIKit
SIPPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SIPPrefs.plist$(ECHO_END)
