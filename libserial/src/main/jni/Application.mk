# NDK_TOOLCHAIN_VERSION := clang

ifeq ($(NDK_DEBUG), 1)
APP_OPTIM := debug
else
APP_OPTIM := release
endif

APP_PLATFORM := android-28
APP_ABI := all
APP_STL := c++_static
#APP_CFLAGS := -std=gnu11
APP_CPPFLAGS := -fexceptions
