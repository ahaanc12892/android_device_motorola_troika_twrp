#!/bin/bash
# Package twrp-installer zip from a built recovery.img (A/B, both slots)
# Usage: ./make-installer.sh <recovery.img> [out.zip]
set -e
IMG="${1:?recovery.img path required}"
OUT="${2:-twrp-troika-installer.zip}"
DEV=device/motorola/troika
WORK=$(mktemp -d)
trap "rm -rf $WORK" EXIT

mkdir -p "$WORK/META-INF/com/google/android"
cp "$IMG" "$WORK/recovery.img"
cp "$DEV/installer/magiskboot-arm64" "$WORK/"
cp "$DEV/installer/META-INF/com/google/android/update-binary" "$WORK/META-INF/com/google/android/"
cp "$DEV/installer/META-INF/com/google/android/updater-script" "$WORK/META-INF/com/google/android/"

cd "$WORK"
zip -qr "$OLDPWD/$OUT" .
echo "wrote $OUT"
