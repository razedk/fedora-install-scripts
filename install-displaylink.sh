#!/bin/bash

#
# This scripts downloads and install display link drivers (evdi)
#
# NOTE: Script is made for Fedora and might not work on other distributions
#

source util/print-util.sh
source util/secure-boot-util.sh
source util/dkms-util.sh

#
# F U N C T I O N S   S E C T I O N
#

# Download rpm
download_rpm() {
    local download_folder="$1"
    local download_url="$2"
    
    # Download rpm to specified download folder
    cd $download_folder 
    wget $download_url
}

# Handle secure boot
enroll_dkms_key() {
    # Only register if secure boot is enabled
    if [[ $(secure_boot_util_secure_boot_enabled) == "false" ]]; then
        #print_info "Secure boot is disabled, no need to sign driver"
        return
    fi
    
    # Verify that module is signed with DKMS key
    if [[ $(dkms_util_is_dkms_signed) == "false" ]]; then
        print_error "Secure boot is enabled but module is not DKMS assigned as expected, cannot continue"
        return  
    fi

    # Enroll DKMS key if not already enrolled
    dkms_util_enroll_key
}


#
# M A I N   S E C T I O N
#


# Specify the file you want to monitor
DOWNLOAD_PATH="$HOME/Downloads/"
DOWNLOAD_FILE_NAME="fedora-38-displaylink-1.14.1-1.x86_64.rpm"
DOWNLOAD_COMPLETE_NAME="$DOWNLOAD_PATH$DOWNLOAD_FILE_NAME"
DOWNLOAD_URL="https://github.com/displaylink-rpm/displaylink-rpm/releases/download/v5.8.0/$DOWNLOAD_FILE_NAME"

# Download displaylink driver (delete any previous downloads)
rm "$DOWNLOAD_PATH$DOWNLOAD_FILE_NAME"
download_rpm $DOWNLOAD_PATH $DOWNLOAD_URL

if [ -e "$DOWNLOAD_COMPLETE_NAME" ]; then
    # Install build files and display link driver
    sudo dnf groupinstall -y "C Development Tools and Libraries"
    sudo dnf install -y "$DOWNLOAD_COMPLETE_NAME"
    print_ok "Install of dislaylink has completed"
    
    # Enroll DKMS signing key if not already enrolled
    dkms_util_enroll_key
else 
    print_error "Install of displaylink has failed"
fi


