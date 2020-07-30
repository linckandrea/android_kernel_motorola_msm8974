export ARCH=arm && export SUBARCH=arm
make clean && make mrproper
export CROSS_COMPILE=/home/andrea/TC/bin/arm-eabi-
make lineageos_victara_defconfig
make -j4
