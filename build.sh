#!/bin/bash

# Kernel Version
BASE_VER=".NEX"
VER=".D2SPR.0001"
VER=$BASE_VER$VER

export LOCALVERSION=""`echo $VER`

# toolchain
export CROSS_COMPILE=~/storage/toolchains/linaro/4.9.1/arm-cortex_a15-linux-gnueabihf-linaro_4.9.1-2014.06/bin/arm-eabi-
#export CROSS_COMPILE=~/storage/toolchains/linaro/4.9.1/arm-cortex_a9-linux-gnueabihf-linaro_4.9.1-2014.06/bin/arm-eabi-
#export CROSS_COMPILE=~/storage/toolchains/ndk/4.6/bin/arm-eabi-

# make .config
make msm8960_m2_defconfig VARIANT_DEFCONFIG=msm8960_m2_spr_defconfig SELINUX_DEFCONFIG=selinux_defconfig
env KCONFIG_NOTIMESTAMP=true \
make ARCH=arm SUBARCH=arm VARIANT_DEFCONFIG=msm8960_m2_spr_defconfig SELINUX=selinux_defconfig

# build the kernel
if [ "$1" == "modules" ]
then
  make -j32 modules
else
  make -j32 && make modules -j32
fi
