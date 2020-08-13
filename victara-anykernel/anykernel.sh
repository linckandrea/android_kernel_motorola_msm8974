# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Pop kernel by linckandrea @ xda-developers
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=xt1092
device.name2=xt1095
device.name3=xt1097
device.name4=victara
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## AnyKernel install
/tmp/anykernel/tools/busybox mount -o rw,remount -t auto /system;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.target.rc
replace_string "/system/vendor/etc/init/hw/init.target.rc" "service mpdecision /system/vendor/bin/mpdecision --avg_comp --Nw=1:1.99 --Nw=2:2.99 --Nw=3:3.99 --Tw=2:140 --Tw=3:140 --Ts=2:190 --Ts=3:190" "service mpdecision /system/vendor/bin/mpdecision --avg_comp" "service mpdecision /system/vendor/bin/mpdecision --avg_comp --Nw=1:1.99 --Nw=2:2.99 --Nw=3:3.99 --Tw=2:140 --Tw=3:140 --Ts=2:190 --Ts=3:190"

# init.qcom.power.rc

# remove mpdecision
remove_line "/system/vendor/etc/init/hw/init.qcom.rc" "start mpdecision";

# remove cpu_boost settings (we use sultan's variant)
remove_line "/system/vendor/etc/init/hw/init.qcom.rc" "write /sys/module/cpu_boost/parameters/boost_ms 20";
remove_line "/system/vendor/etc/init/hw/init.qcom.rc" "write /sys/module/cpu_boost/parameters/sync_threshold 1728000";
remove_line "/system/vendor/etc/init/hw/init.qcom.rc" "write /sys/module/cpu_boost/parameters/input_boost_freq 1497600";
remove_line "/system/vendor/etc/init/hw/init.qcom.rc" "write /sys/module/cpu_boost/parameters/input_boost_ms 40";

# set min cpu freq 
replace_string "/system/vendor/etc/init/hw/init.qcom.rc" "268800" "300000" "268800" "global";

# add Pop kernel Script
ui_print "- Applying Pop kernel init patch in /system/vendor"
cp /tmp/anykernel/ramdisk/init.pop.rc /system/vendor/etc/init/hw/init.pop.rc;
insert_line "/system/vendor/etc/init/hw/init.qcom.rc" "init.pop.rc" after "import /vendor/etc/init/hw/init.target.rc" "import /vendor/etc/init/hw/init.pop.rc";
chmod 644 /system/vendor/etc/init/hw/init.pop.rc;


# end ramdisk changes

write_boot;
/tmp/anykernel/tools/busybox mount -o ro,remount -t auto /system;
## end install

