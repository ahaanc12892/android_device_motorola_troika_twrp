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

PLATFORM_PATH := device/motorola/troika

# define hardware platform
PRODUCT_PLATFORM := exynos9610

# A/B support - update_engine_sideload handles payload.bin (full OTA) installs
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload

# Boot control HAL - the HIDL android.hardware.boot@1.0-service (prebuilt in
# recovery/root/system/bin) provides slot control to update_engine_sideload via
# libboot_control_client; bootctrl.exynos9610 is the legacy hw_get_module path.
PRODUCT_PACKAGES += \
    bootctrl.exynos9610

# HIDL interface libs required by the prebuilt HAL service binaries
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0 \
    android.hardware.keymaster@3.0 \
    android.hardware.gatekeeper@1.0

# NOTE: the keymaster/gatekeeper/boot HAL *service binaries* are prebuilt
# (recovery/root/system/bin) from stock Android 9/11 - they load the
# hardware (TEE-backed) impl libraries. Building android.hardware.keymaster@3.0-service
# from AOSP source would yield the SOFTWARE keymaster, which cannot unwrap
# keys protected by the TrustZone TEE.
