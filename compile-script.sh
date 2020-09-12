echo
echo "Setup"
echo 

mkdir -p out
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=/home/andrea/gcc10/arm32-gcc/bin/arm-eabi-

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

rm ./victara-anykernel/zImage-dtb
cp ./out/arch/arm/boot/zImage-dtb ./victara-anykernel
cd victara-anykernel
rm ./Pop_kernel-victara-Q-rx-x.zip
zip -r9 Pop_kernel-victara-Q-rx-x.zip * -x .git README.md *placeholder
cd ..
