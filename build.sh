#!/bin/bash

# Kernel Version
VER="-NexT_0001"

export LOCALVERSION=""`echo $VER`

# toolchain
#export CROSS_COMPILE=~/storage/toolchains/linaro/arm-cortex_a15-linux-gnueabihf-linaro_4.9.1-2014.06/bin/arm-eabi-
#export CROSS_COMPILE=~/storage/toolchains/linaro/arm-cortex_a9-linux-gnueabihf-linaro_4.9.1-2014.06/bin/arm-eabi-
#export CROSS_COMPILE=~/storage/toolchains/ndk/4.6/bin/arm-eabi-
export CROSS_COMPILE=~/storage/toolchains/linaro/arm-cortex_a9-linux-gnueabihf-linaro_4.7.4-2014.04/bin/arm-gnueabi-

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
