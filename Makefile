export TARGET = iphone:clang:17.5:15.0
export SDK_PATH = $(THEOS)/sdks/iPhoneOS17.5.sdk/
export SYSROOT = $(SDK_PATH)
export ARCHS = arm64

ifneq ($(JAILBROKEN),1)
export DEBUGFLAG = -ggdb -Wno-unused-command-line-argument -L$(THEOS_OBJ_DIR)
MODULES = jailed
endif

ifndef YOUTUBE_VERSION
YOUTUBE_VERSION = 20.23.3
endif
ifndef YOUTUBE_REBORN_VERSION
YOUTUBE_REBORN_VERSION = 4.2.9
endif
PACKAGE_NAME = $(TWEAK_NAME)
PACKAGE_VERSION = $(YOUTUBE_VERSION)-$(YOUTUBE_REBORN_VERSION)

INSTALL_TARGET_PROCESSES = YouTube
TWEAK_NAME = YouTubeReborn
DISPLAY_NAME = YouTube
BUNDLE_ID = com.google.ios.youtube

YouTubeReborn_FILES = Tweak.xm $(wildcard Controllers/*.m) $(wildcard AFNetworking/*.m) $(wildcard YouTubeExtractor/*.m)
YouTubeReborn_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos Accelerate CoreMotion GameController VideoToolbox UniformTypeIdentifiers
YouTubeReborn_LIBRARIES = bz2 c++ iconv z
YouTubeReborn_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
YouTubeReborn_IPA = tmp/Payload/YouTube.app
YouTubeReborn_OBJ_FILES = $(wildcard lib/*.a)

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

REMOVE_EXTENSIONS = 1
CODESIGN_IPA = 0
