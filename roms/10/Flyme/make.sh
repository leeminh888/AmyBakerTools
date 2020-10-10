#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# build.prop
echo "ro.bootprof.disable=1" >> $1/build.prop

# Custom files
cp -fpr $thispath/lib64/* $1/lib64/
cp -fpr $thispath/erfan $1/
cp -fpr $thispath/init/* $1/etc/init/
cp -fpr $thispath/bin/* $1/bin/
cp -fpr $thispath/overlay/* $1/product/overlay/
cp -fpr $thispath/framework/* $1/framework/

# hack bootprof
sed -i "s|/sys/bootprof/bootprof|/system/erfan/bootprof|g" $1/lib/libsurfaceflinger.so
sed -i "s|/sys/bootprof/bootprof|/system/erfan/bootprof|g" $1/lib64/libsurfaceflinger.so

# Remove com.wolfsonmicro.ez2control:ez2control_service for a moment
# It is crashing from systemserver booted which has triggered RescueParty
# It hurts performance very much and make device very hot
# cpufreq is running at a high freq
rm -rf $1/app/com.wolfsonmicro.ez2control

# Append file_context
cat $thispath/file_contexts >> $1/etc/selinux/plat_file_contexts

#to improve the perfomance of GSIs
echo "ro.sys.fw.dex2oat_thread_count=4" >> $1/build.prop
echo "dalvik.vm.boot-dex2oat-threads=8" >> $1/build.prop
echo "dalvik.vm.dex2oat-threads=4" >> $1/build.prop
echo "dalvik.vm.image-dex2oat-threads=4" >> $1/build.prop
echo "dalvik.vm.dex2oat-filter=speed" >> $1/build.prop
echo "dalvik.vm.heapgrowthlimit=256m" >> $1/build.prop
echo "dalvik.vm.heapstartsize=8m" >> $1/build.prop
echo "dalvik.vm.heapsize=512m" >> $1/build.prop
echo "dalvik.vm.heaptargetutilization=0.75" >> $1/build.prop
echo "dalvik.vm.heapminfree=512k" >> $1/build.prop
echo "dalvik.vm.heapmaxfree=8m" >> $1/build.prop
echo "ro.bluetooth.library_name=libbluetooth_qti.so" >> $1/build.prop


#Navbar fix
echo "qemu.hw.mainkeys=0" >> $1/build.prop

