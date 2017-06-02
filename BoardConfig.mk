DEVICE_PATH := device/blu/p6601
VENDOR_PATH := vendor/blu/p6601

USE_CAMERA_STUB := true

# mt6735 supports x64 but is disabled?
FORCE_32_BIT := true

# inherit from the proprietary version
-include $(VENDOR_PATH)/BoardConfigVendor.mk

TARGET_BOARD_PLATFORM := mt6735
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_BOARD_PLATFORM)
TARGET_NO_BOOTLOADER := true

# Architecture
ifeq ($(FORCE_32_BIT),true)
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53
else
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53
endif

TARGET_CPU_SMP := true

ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HAVE_NEON := true
ARCH_ARM_HAVE_VFP := true

TARGET_GLOBAL_CFLAGS   += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

# WiFi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA:=STA
WIFI_DRIVER_FW_PATH_AP:=AP
WIFI_DRIVER_FW_PATH_P2P:=P2P

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MTK := true
BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL := true

#EGL settings
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := $(DEVICE_PATH)/egl.cfg

# RIL
BOARD_RIL_CLASS := ../../../$(DEVICE_PATH)/ril

BOARD_SEPOLICY_DIRS := $(DEVICE_PATH)/sepolicy

TARGET_LDPRELOAD += libxlog.so:libmtk_symbols.so

BOARD_SECCOMP_POLICY := $(DEVICE_PATH)/seccomp

# Kernel properties
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE = 0x40000000
BOARD_RAMDISK_OFFSET = 0x04000000
BOARD_KERNEL_OFFSET = 0x00008000
BOARD_TAGS_OFFSET = 0x0e000000
BOARD_REL_NAME = BLU_R0010UU_V6.
TARGET_KERNEL_SOURCE := kernel/blu/p6601
TARGET_KERNEL_CONFIG := p6601_defconfig

ifeq ($(FORCE_32_BIT),true)
TARGET_KERNEL_ARCH := arm
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,32N2 androidboot.selinux=permissive
else
TARGET_KERNEL_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
TARGET_USES_64_BIT_BINDER := true
endif

BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_TAGS_OFFSET) --board $(BOARD_REL_NAME)

# Mediatek flags
CONFIG_MTK_PLATFORM := $(TARGET_BOARD_PLATFORM) # used in kernel src
BOARD_USES_MTK_HARDWARE := true # see vendor/cm/buuild/core/mtk_target.mk

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2801795072
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12339118080
BOARD_CACHEIMAGE_PARTITION_SIZE := 419430400
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true

# Recovery 
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_NO_MISC_PARTITION := true
#TARGET_RECOVERY_INITRC := $(DEVICE_PATH)/recovery/init.mt6753.rc
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/fstab.mt6735
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness\"

# Test (for using modified framework)
BOARD_USES_LEGACY_MTK_AV_BLOB := true
BOARD_HAS_MTK_HARDWARE := true

#TARGET_USES_MEDIA_EXTENSIONS := false
#TARGET_HAS_LEGACY_CAMERA_HAL1 := true

# Mediatek 
#ifeq ($(BOARD_HAS_MTK_HARDWARE),true)
#MTK_GLOBAL_C_INCLUDES:=
#MTK_GLOBAL_CFLAGS:=
#MTK_GLOBAL_CONLYFLAGS:=
#MTK_GLOBAL_CPPFLAGS:=
#MTK_GLOBAL_LDFLAGS:=

#MTK_GLOBAL_CFLAGS += -DMTK_AOSP_ENHANCEMENT
#MTK_PATH_SOURCE := vendor/mediatek/proprietary
#MTK_ROOT := vendor/mediatek/proprietary

#$(info *** Mediatek Platform Used ***)
#endif

#system.prop
TARGET_SYSTEM_PROP := $(DEVICE_PATH)/system.prop
