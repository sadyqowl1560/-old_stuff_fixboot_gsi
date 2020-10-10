#!/bin/bash
#
#################
# Fix booting  gsi  
#################
if cat /system/build.prop |grep "config.disable_consumerir=true" ; then
 echo
else
 printf "\n#Gsi_Fixbootv3\nconfig.disable_consumerir=true" >> /system/build.prop
fi
##
First_line=$(grep -irn  "#If we have both Samsung and AOSP power hal" /system/bin/rw-system.sh  | grep -o '[0-9][0-9][0-9]')
#ADDING 4 LINES WHICH  WE need to ..........  .
Last_line=$(( First_line+4 ))
input="${First_line},${Last_line}d"
#DELETING
sed  $input\  /system/bin/rw-system.sh>/system/bin/tmp.sh
rm /system/bin/rw-system.sh 
mv /system/bin/tmp.sh /system/bin/rw-system.sh 
#CHANGING PERMISSION  
chmod 644  /system/bin/rw-system.sh
###
#####################################
# Fix booting Q gsi with oreo vendor & magisk 
#####################################
if cat /vendor/build.prop |grep ro.vendor.build.fingerprint |grep :8 ; then
 if cat /system/build.prop |grep ro.system.build.fingerprint |grep :10 ; then
 cat /vendor/etc/selinux/nonplat_sepolicy.cil |grep -v exfat > /vendor/etc/selinux/nonplat_sepolicy.cilc
  mv /vendor/etc/selinux/nonplat_sepolicy.cilc /vendor/etc/selinux/nonplat_sepolicy.cil
  chcon u:object_r:sepolicy_file:s0 /vendor/etc/selinux/nonplat_sepolicy.cil
 chmod 644 /vendor/etc/selinux/nonplat_sepolicy.cil
 fi
fi