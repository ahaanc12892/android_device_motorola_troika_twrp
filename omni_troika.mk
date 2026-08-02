# Copyright 2017 The Android Open Source Project
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

PRODUCT_RELEASE_NAME := troika

$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, device/motorola/troika/device.mk)

PRODUCT_DEVICE := troika
PRODUCT_NAME := omni_troika
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola one action
PRODUCT_MANUFACTURER := motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=troika \
    BUILD_PRODUCT=troika \
    TARGET_DEVICE=troika

# ro.product.device=troika (from PRODUCT_DEVICE) passes the update_engine
# "pre-device" check against the OTA metadata list "troika,one_action".
