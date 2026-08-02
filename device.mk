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
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_engine_sideload \
    update_verifier

# Enable update engine sideloading by including the static version of the
# boot_control HAL and its dependencies.
PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.exynos9610 \
    libz \
    libcutils

# Boot control HAL (legacy hw_get_module path used as fallback)
PRODUCT_PACKAGES += \
    bootctrl.exynos9610

# HAL services for decryption + A/B, built from the android-14.1 tree
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-service \
    android.hardware.keymaster@3.0-service \
    android.hardware.gatekeeper@1.0-service
