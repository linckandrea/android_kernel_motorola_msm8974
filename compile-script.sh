	export ARCH=arm
	export SUBARCH=arm
	export CROSS_COMPILE="/home/andrea/TC/bin/arm-eabi-"
	export LD_LIBRARY_PATH="/home/andrea/lolz_clang/lib"
	echo "Performing a full clean..."
	make mrproper CC=/home/andrea/lolz_clang/bin/clang HOSTCC=/home/andrea/lolz_clang/bin/clang
	make clean CC=/home/andrea/lolz_clang/bin/clang HOSTCC=/home/andrea/lolz_clang/bin/clang
    make lineageos_victara_defconfig CC=/home/andrea/lolz_clang/bin/clang HOSTCC=/home/andrea/lolz_clang/bin/clang
