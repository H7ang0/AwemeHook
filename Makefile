ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Aweme

include $(THEOS)/makefiles/common.mk

# 有根版本
TWEAK_NAME = AwemeHuaji

AwemeHuaji_FILES = Tweak.xm
AwemeHuaji_CFLAGS = -fobjc-arc

# 无根版本
BUNDLE_NAME = AwemeHuajiRootless

AwemeHuajiRootless_FILES = Tweak.xm
AwemeHuajiRootless_CFLAGS = -fobjc-arc
AwemeHuajiRootless_INSTALL_PATH = /var/jb/Library/MobileSubstrate/DynamicLibraries

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk