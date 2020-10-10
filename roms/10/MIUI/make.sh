#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# build.prop
#echo "ro.bluetooth.library_name=libbluetooth_qti.so" >> $1/build.prop

# drop finddevice, needs to be done before copying system files
rm -rf $1/priv-app/FindDevice

# Copy system files
rsync -ra $thispath/system/ $systempath

#fix systemui crash because of FOD
echo "ro.hardware.fp.fod=true" >> $1/build.prop
echo "persist.vendor.sys.fp.fod.location.X_Y=445,1260" >> $1/build.prop
echo "persist.vendor.sys.fp.fod.size.width_height=190,190" >> $1/build.prop
echo "DEVICE_PROVISIONED=1" >> $1/build.prop

# drop dirac
rm -rf $1/priv-app/DiracAudioControlService
# drop FingerprintExtensionService
rm -rf $1/app/FingerprintExtensionService
# drop nfc
rm -rf $1/app/NQNfcNci

cat $thispath/rw-system.add.sh >> $1/bin/rw-system.sh

sed -i 's/<bool name="support_round_corner">true/<bool name="support_round_corner">false/' $1/etc/device_features/*

sed -i "/miui.notch/d" $1/build.prop

# Wifi fix
cp -fpr $thispath/bin/* $1/bin/
cat $thispath/rw-system.add.sh >> $1/bin/rw-system.sh

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

