PLATFORM := linux # android, linux

TARGET := hello
SOURCES := src/main.ll
OUT_DIR := dist

CC := clang
CXX := clang++

ifeq ($(PLATFORM), android)

ifeq ($(TOOLCHAIN),)
NDK_PATH := /home/zero/Android/Sdk/ndk/28.0.12916984
TOOLCHAIN := $(NDK_PATH)/toolchains/llvm/prebuilt/linux-x86_64
endif

TARGET_ARCH := aarch64
API_LEVEL := 23

CC := $(TOOLCHAIN)/bin/$(TARGET_ARCH)-linux-android$(API_LEVEL)-clang
CXX := $(TOOLCHAIN)/bin/$(TARGET_ARCH)-linux-android$(API_LEVEL)-clang++
endif

DOCKER_IMAGE_NAME=clang
DOCKER_IMAGE_TAG=19.1.4-r0

define optZ
	$(eval oZ = $(1))
	mkdir -p $(OUT_DIR)
	opt -O$(oZ) -S $(SOURCES) -o $(OUT_DIR)/o$(oZ).ll 
	$(CC) $(OUT_DIR)/o$(oZ).ll -o $(OUT_DIR)/$(TARGET)-o$(oZ)
	cp $(OUT_DIR)/$(TARGET)-o$(oZ) $(OUT_DIR)/$(TARGET)
endef

