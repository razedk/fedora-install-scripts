#!/bin/bash

#
# This script sets up network drives
#
# NOTE: Script is made for Fedora and might not work on other distributions
#
source config/common-config.sh
source util/print-util.sh

# Constants
MY_SHARES_TEXT="# My shares"
FSTAB_FILE="/etc/fstab"

#
# F U N C T I O N S   S E C T I O N
#

is_already_installed() {
   if grep -Fxq "$MY_SHARES_TEXT" $FSTAB_FILE
   then
      echo "true"
   else
      echo "false"
   fi
}

add_nas_credentials() {
    cp "$BACKUP_DIR/home/.nascredentials" $HOME
    chmod 600 $HOME/.nascredentials
}

add_mount_config() {
    echo "$MY_SHARES_TEXT" | sudo tee -a $FSTAB_FILE >/dev/null
    echo "//$NAS_IP/Multimedia $MOUNT_DIR/Multimedia cifs credentials=$HOME/.nascredentials,uid=1000,gid=1000 0 0" | sudo tee -a $FSTAB_FILE >/dev/null
    echo "//$NAS_IP/Download $MOUNT_DIR/Download cifs credentials=$HOME/.nascredentials,uid=1000,gid=1000 0 0" | sudo tee -a $FSTAB_FILE >/dev/null
    echo "//$NAS_IP/Public $MOUNT_DIR/Public cifs credentials=$HOME/.nascredentials,uid=1000,gid=1000 0 0" | sudo tee -a $FSTAB_FILE >/dev/null
}

create_mount_dirs() {
    sudo mkdir $MOUNT_DIR/Multimedia
    sudo mkdir $MOUNT_DIR/Download
    sudo mkdir $MOUNT_DIR/Public
}


#
# M A I N   S E C T I O N
#

if [[ $(is_already_installed) == "false" ]]; then
    add_nas_credentials
    create_mount_dirs
    add_mount_config
    sudo mount -a
    systemctl daemon-reload
    print_ok "Network shares added to fstab"
else
    print_info "Network shares were already added, no changes done"
fi



    
  
