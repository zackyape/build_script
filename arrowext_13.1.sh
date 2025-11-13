#!/bin/bash

# remove old manifests
rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/ArrowOS-T/android_manifest -b arrow-13.1_ext --depth 1 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Remove tree
rm -rf device/xiaomi/vayu
rm -rf hardware/xiaomi
rm -rf vendor/xiaomi/vayu
rm -rf kernel/xiaomi/vayu
rm -rf vendor/xiaomi/vayu-miuicamera

# clone local_manifests
git clone https://github.com/zackyape/android_device_xiaomi_vayu_arrow -b arrow-13.1 device/xiaomi/vayu
git clone https://github.com/bagaskara815/vendor_xiaomi_vayu-miuicamera vendor/xiaomi/vayu-miuicamera
git clone https://github.com/arrowos-devices/android_vendor_xiaomi_vayu -b arrow-13.1 vendor/xiaomi/vayu
git clone https://github.com/arrowos-devices/android_kernel_xiaomi_vayu -b arrow-13.1 kernel/xiaomi/vayu
git clone https://github.com/arrowos-devices/android_hardware_xiaomi -b arrow-13.1 hardware/xiaomi
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

# Create symlink
sudo ln -s /usr/lib32/libncurses.so.6.4 /usr/lib32/libncurses.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6.4 /usr/lib/x86_64-linux-gnu/libncurses.so.5

sudo ln -s /usr/lib32/libtinfo.so.6.4 /usr/lib32/libtinfo.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6.4 /usr/lib/x86_64-linux-gnu/libtinfo.so.5

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
