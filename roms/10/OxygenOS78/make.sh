#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# Copy system files
rsync -ra $thispath/system/ $systempath

# Append file_context
cat $thispath/file_contexts >> $1/etc/selinux/plat_file_contexts

#Soundsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
echo "ro.config.mms_notification=free.ogg" >> $1/etc/prop.default
echo "ro.config.notification_sound=meet.ogg" >> $1/etc/prop.default
echo "ro.config.alarm_alert=spring.ogg" >> $1/etc/prop.default
echo "ro.config.ringtone=oneplus_tune.ogg" >> $1/etc/prop.default

# fix bt audio for op gsi
sed -i "/\/vendor\/etc\/audio /d" $1/bin/rw-system.sh

# drop dirac
rm -rf $1/app/NxpNfcNci

# fix op6t notch
sed -i "s/M-185,0 H183.34 c-9.77.44-19.57,0.08-29.28,1.24-20.33,1.14-41.18,5.17-58.62,16.24 C78.54,28.27,66,44.26,52,58.29 a72.73,72.73,0,0,1-38.29,19.58 c-16.53,2.51-34,1-49.09-6.62-9.85-4.62-17.88-12.24-25.21-20.18-10.46-11.27-20.9-22.75-33.53-31.66-11.49-8-24.9-12.78-38.53-15.42 C-149.92,0.81,-167.51.39,-185,0Z/00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000/" $1/framework/framework-res.apk

# fix op6 notch
sed -i "s/M 0,0 L -183, 0 A 24.0, 24.0, 0, 0, 1, -159.0, 22.0 A 64.0, 64.0, 0, 0, 0, -95.0, 80.0 L 95.0, 80.0 A 64.0, 64.0, 0, 0, 0, 159.0, 22.0 A 24.0, 24.0, 0, 0, 1, 183.0, 0 Z/000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000/" $1/framework/framework-res.apk
sed -i "s/M-184.95,0 C-168,0.12,-160.84,7.45,-158.7,24.11 c4,31.21,25.33,54.92,63.5,54.92 H95.2 c38.18,0,59.5-23.71,63.5-54.92 C160.84,7.45,168,.12,184.95,0 H-184.95Z/000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000/" $1/framework/framework-res.apk

# Wifi fix
cp -fpr $thispath/bin/* $1/bin/
cat $thispath/rw-system.add.sh >> $1/bin/rw-system.sh

## Fix OOS Data, kang from flyme fix
# Permission
chmod 0644 $1/etc/init/flymedata.rc

# batteryDrain Fix
rm -rf $1/bin/logcat
rm -rf $1/etc/init/hdrfix
rm -rf $1/bin/hdrfix

#To Boot OnePlus7T and OnePlus7TPro
cp $thispath/feature_list $1/etc
chmod 0644 $1/etc/feature_list

#To Boot OnePlus8 series 
#cp $thispath/surfaceflinger $1/bin

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

