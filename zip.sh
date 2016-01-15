#!/bin/bash

#get all files
cp arch/arm/boot/zImage ../builds/AIK-Linux/split_img
cp drivers/scsi/scsi_wait_scan.ko ../builds/system/lib/modules
cp drivers/net/wireless/bcmdhd/dhd.ko ../builds/system/lib/modules

#Add zImage to boot.img
cd ../builds/AIK-Linux/split_img
mv zImage boot.img-zImage
cd ..
./repackimg.sh
cp image-new.img ..

#Add boot.img to zip
cd ..
mv image-new.img boot.img
cp *.zip previousbuilds/
mv *.zip test.zip
zip -g test.zip boot.img
zip -g test.zip system/lib/modules/scsi_wait_scan.ko
zip -g test.zip system/lib/modules/dhd.ko

#Name new kernel.zip
echo "Enter name of new zip: "
read input_variable
mv test.zip $input_variable.zip
echo "$input_variable.zip is ready"