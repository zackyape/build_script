#!/bin/bash

# remove old manifests
rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/ArrowOS-T/android_manifest -b arrow-13.1_ext --depth 1 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# clone local_manifests
git clone https://github.com/zackyape/android_device_xiaomi_vayu_arrow -b arrow-13.1 device/xiaomi/vayu
git clone https://github.com/bagaskara815/vendor_xiaomi_vayu-miuicamera vendor/xiaomi/vayu-miuicamera
git clone https://github.com/arrowos-devices/android_vendor_xiaomi_vayu -b arrow-13.1 vendor/xiaomi/vayu
git clone https://github.com/arrowos-devices/android_kernel_xiaomi_vayu -b arrow-13.1 kernel/xiaomi/vayu
git clone https://github.com/arrowos-devices/android_hardware_xiaomi -b arrow-13.1 hardware/xiaomi/
echo "=================="
echo "Local manifests clone success"
echo "=================="

# Build Sync
/opt/crave/resync.sh
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=Zacky 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
lunch arrow_vayu-userdebug
echo "============"

#Make clean install
make installclean
echo "============="

# Build
m bacon
