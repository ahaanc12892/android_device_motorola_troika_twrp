#
# Copyright (C) 2013-2026 The TWRP/OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Motorola One Action (troika) - TWRP device configuration
# Modern bring-up on the TeamWin twrp-14.1 (android-14.1) base,
# ported from the SHRP/omni-9 device tree.

DEVICE_PATH := device/motorola/troika

ALLOW_MISSING_DEPENDENCIES := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := exynos9610
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true
TARGET_BOOTLOADER_IS_2ND := true

# Platform
TARGET_BOARD_PLATFORM := exynos9610
TARGET_BOARD_PLATFORM_GPU := mali-g72
TARGET_SOC := exynos9610
TARGET_USES_64_BIT_BINDER := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# CPUSets
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Kernel - prebuilt from LineageOS 23.2 (Android 16) boot image
# (kernel 4.14, includes Mobicore TEE driver required for decryption)
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_NO_KERNEL := false
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image
BOARD_KERNEL_IMAGE_NAME := Image
# second = DTB, extracted from the LineageOS boot image (Exynos/Samsung layout)
BOARD_MKBOOTIMG_ARGS := --second $(DEVICE_PATH)/prebuilt/second.bin

BOARD_KERNEL_CMDLINE := loop.max_part=7 androidboot.selinux=permissive androidboot.fastboot=1 androidboot.boot_devices=13520000.ufs
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x00000000
BOARD_SECOND_OFFSET := 0x00000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000000
BOARD_BOOT_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --second_offset $(BOARD_SECOND_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --header_version $(BOARD_BOOT_HEADER_VERSION)

# Partitions (from LineageOS common tree)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368
BOARD_DTBOIMAGE_PARTITION_SIZE := 1048576
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_USES_METADATA_PARTITION := true

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    vbmeta \
    vendor
# TWRP builds a standalone recovery image (kernel + TWRP ramdisk) which is
# booted via `fastboot boot` or flashed to the boot partition (recovery-as-boot).
TARGET_NO_RECOVERY := false

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "ABGR_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/etc/twrp.fstab
TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/recovery.wipe
RECOVERY_SDCARD_ON_DATA := true

# Boot control HAL (required by update_engine_sideload for A/B payload installs)
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.boot@1.0 \
    android.hardware.boot@1.0-impl.exynos \
    bootctrl.exynos9610

# Crypto / decryption (stock keymaster 3.0 + gatekeeper 1.0 + Mobicore TEE blobs)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true

# TWRP
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/class/backlight/backlight_0/brightness"
TW_DEFAULT_BRIGHTNESS := 80
TW_NO_SCREEN_BLANK := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_EXCLUDE_SUPERSU := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_INCLUDE_NTFS_3G := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_USE_TOOLBOX := true
TW_EXCLUDE_TWRPAPP := true
TW_INCLUDE_REPACKTOOLS := true
TW_EXTRA_LANGUAGES := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Haptics (aw8695 firmware shipped in ramdisk)
#TW_NO_HAPTICS := true

# Installer zip (A/B template, installs TWRP to boot on both slots)
USE_RECOVERY_INSTALLER := true
RECOVERY_INSTALLER_PATH := $(DEVICE_PATH)/installer

# Version props - kept in sync with current LineageOS so that
# update_engine_sideload's downgrade checks pass (prepdecrypt.sh then
# overrides them from the installed system before decryption)
PLATFORM_SECURITY_PATCH := 2026-07-01
VENDOR_SECURITY_PATCH := 2026-07-01
PLATFORM_VERSION := 16.1.0

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/system.prop
