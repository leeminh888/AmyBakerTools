#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# AOSP libs
cp -fpr $thispath/overlay/* $1/product/overlay/

# Append file_context
sed -i "s/persist.sys.usb.config=none/persist.sys.usb.config=adb/g" $1/etc/prop.default
#echo "ro.setupwizard.mode=DISABLED" >> $1/etc/prop.default
echo "ro.boot.vendor.overlay.theme=com.google.android.theme.pixel" >> $1/etc/prop.default
echo "ro.config.ringtone=The_big_adventure.ogg" >> $1/etc/prop.default
echo "ro.config.notification_sound=Popcorn.ogg" >> $1/etc/prop.default
echo "ro.config.alarm_alert=Bright_morning.ogg" >> $1/etc/prop.default
echo "persist.sys.overlay.pixelrecents=true" >> $1/etc/prop.default
echo "persist.sys.overlay.photness=true" >> $1/etc/prop.default
echo "qemu.hw.mainkeys=0" >> $1/etc/prop.default

sed -i "/dataservice_app/d" $1/product/etc/selinux/product_seapp_contexts

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

