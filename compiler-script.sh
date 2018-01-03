export ARCH=arm && export SUBARCH=arm

export CROSS_COMPILE=/home/andrea/UxL/bin/arm-eabi-

make victara_defconfig

make -j2
