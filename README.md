# TWRP 3.7.1 for Motorola One Action (troika)

Modern TWRP device tree for the Motorola One Action (Exynos 9610), built on the
TeamWin **twrp-14.1** (android-14.1 / AOSP 14) base. Ported from the legacy
SHRP / omni-9 device tree, which suffered from:

* **Error 255 when installing ROMs** — the old omni-9-era `update_engine_sideload`
  cannot parse modern (Android 13+) `payload.bin` OTAs. LineageOS 23.2 (Android 16)
  ships as a pure payload OTA, so installs aborted with 255.
* **Broken/outdated TWRP** — last real update was 2021 (TWRP 3.7.0 on an
  android-9 base); decryption breaks with monthly security updates.

## What's fixed / included

* **Modern base**: TWRP 3.7.1 on android-14.1 — 64-bit recovery, modern
  `update_engine_sideload` that installs Android 16 payload OTAs (LineageOS 23.2)
* **A/B installs**: payload.bin installs via update_engine + bootctrl.exynos9610
  HAL (built from source, HIDL boot@1.0 service included)
* **Decryption**: stock keymaster 3.0 / gatekeeper 1.0 / Mobicore TEE blobs
  (identical to what stock Android 11 ships), prepdecrypt.sh, FBE v1 + v2 and
  metadata-decrypt support (vold fscrypt v2 path)
* **Kernel/DTB**: prebuilt from the LineageOS 23.2 boot image (kernel 4.14,
  Mobicore TEE driver included), DTB carried in the `second` section
* **Working features**: MTP/ADB (configfs gadget), brightness control, haptics
  firmware (aw8695), backup/restore for efs/persist/persist2/modem/logo/oem,
  NTFS/OTG/SD support, repack tools, extra languages, logcat

## Build

```bash
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp -b twrp-14.1
repo sync -c -j16
# clone this tree to device/motorola/troika
. build/envsetup.sh
lunch omni_troika-eng
make recoveryimage -j$(nproc)
```

Output: `out/target/product/troika/recovery.img`

## Install

```bash
# Bootloader must be unlocked; vbmeta patched if needed
fastboot boot recovery.img        # temporary
fastboot flash boot recovery.img  # permanent (both slots via TWRP "Install Recovery Ramdisk")
```

## Credits

* TeamWin (TWRP), OmniROM, LineageOS (device/kernel), SHRP project
* Original SHRP/TWRP device trees by MNoxx74, kaneawk, ixmoe, Stricted
* Installer template by osm0sis (twrp_abtemplate)
