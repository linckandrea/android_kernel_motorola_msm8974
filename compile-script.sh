export ARCH=arm && export SUBARCH=arm
make clean && make mrproper
export CROSS_COMPILE=/home/andrea/arm-linux-androideabi-7.x/bin/arm-linux-androideabi-
make lineageos_victara_defconfig
make -j2
