#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# move overlays
cp -frp $thispath/overlay/* $1/product/overlay/

# drop VinServiceApp (disable system warning)
rm -rf $1/priv-app/VinServiceApp
rm -rf $1/priv-app/VDefense


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

