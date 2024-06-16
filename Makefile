TARGET := iphone:clang:16.2:15.0
INSTALL_TARGET_PROCESSES = YouTube

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += YTRebornObjc YTRebornSwift

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
