echo
echo "Setup"
echo 

mkdir -p out
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=/home/andrea/TC/bin/arm-eabi-

echo
echo "Clean up"
echo 

make O=out clean
make O=out mrproper

echo
echo "build"
echo 

make O=out lineageos_victara_defconfig
make O=out -j$(nproc --all)
