#!/bin/bash
# make SmartisanOS GSI by:PdyLZY(LZY)

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
# fix boot
# system files by:xiaoxindada
# Copy system files
rsync -ra $thispath/system/ $systempath

# Wifi fix
cp -fpr $thispath/bin/* $1/bin/
cat $thispath/rw-system.add.sh >> $1/bin/rw-system.sh

# Add demo mode
echo " ro.smartisan.experience=0" >> $1/build.prop

# fix build
#echo "ro.product.brand=SMARTISAN" >> $1/build.prop
#echo "ro.product.device=trident" >> $1/build.prop
#echo "ro.product.model=DE106" >> $1/build.prop
#echo "ro.product.name=trident" >> $1/build.prop
#echo "ro.product.manufacturer=deltainno" >> $1/build.prop

# Add SOS overlay
cp -fpr $thispath/overlay/* $1/product/overlay/

# Append file_context
cat $thispath/file_contexts >> $1/etc/selinux/plat_file_contexts

# Fix audio
model=$(sed -n 's/^ro.build.product=[[:space:]]*//p' "$1/build.prop")
size=${#model}
for n in $(seq $size);
do
    new=$new'\x00'
done
sed -i "s/audio_policy_configuration_$model.xml/audio_policy_configuration.xml\x00$new/" "$1/lib/libaudiopolicymanagerdefault.so"
sed -i "s/audio_policy_configuration_$model.xml/audio_policy_configuration.xml\x00$new/" "$1/lib64/libaudiopolicymanagerdefault.so"
sed -i "s/audio_policy_configuration_$model.xml/audio_policy_configuration.xml\x00$new/" "$1/lib/libaudiopolicyenginedefault.so"
sed -i "s/audio_policy_configuration_$model.xml/audio_policy_configuration.xml\x00$new/" "$1/lib64/libaudiopolicyenginedefault.so"
