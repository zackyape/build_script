#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/HinohArata/arrow_manifest.git -b arrow-13.1_ext --depth 1 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/germaniumsculk/local_manifests_lavender .repo/local_manifests -b axion-2.x
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
/opt/crave/resync.sh 
echo "============="
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
lunch arrow_vayu

# Build
m bacon
