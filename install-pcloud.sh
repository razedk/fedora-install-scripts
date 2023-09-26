#!/bin/bash

#
# This scripts downloads and install pCloud
#
# NOTE: Script is made for Fedora and might not work on other distributions
#


#
# F U N C T I O N S   S E C T I O N
#

# Create app folder if it does not already exist
create_directory_if_not_exists() {
    local dir="$1"
    
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Directory '$dir' created."
    else
        echo "Directory '$dir' already exists."
    fi
}

# Download pcloud, when download is started the pcloud file will have a size of 0 until download is completed
download_pcloud() {
    local download_path=$1
    local download_file=$2
    local file_to_download="$1$2"
    # Kill any running firefox otherwise it cannot be started as headless
    pkill firefox > /dev/null 2>&1

    # Download pcloud as 64-bit version
    firefox --headless https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64 > /dev/null 2>&1 &
    
    # Give it time to start the download before checking for download progress
    sleep 5
    
    # Wait for file to be created
    while true; do
        if [ -e "$file_to_download" ]; then
	    if [ -s "$file_to_download" ]; then
	        echo "File '$file_to_download' has been successfully downloaded"
	        # File has been completely downloaded, we can kill headless firefox
	        pkill firefox > /dev/null 2>&1
	        break
	    else
                echo "File '$file_to_download' is still being downloaded"
                eval "ls -laFh --color=always $file_to_download*"
	    fi
        else
           echo "Still waiting for download to start of file '$file_to_download'"
        fi
        # Just to avoid being spammed with progress info
        sleep 5
    done
}


#
# M A I N   S E C T I O N
#

# Define the target folder path
APP_PATH="$HOME/bin/"

# Specify the file you want to monitor
FILE_DOWNLOAD_PATH="$HOME/Downloads/"
FILE_DOWNLOAD_NAME="pcloud"
FILE_COMPLETE_NAME="$FILE_DOWNLOAD_PATH$FILE_DOWNLOAD_NAME"

# Create bin folder if not already exist
create_directory_if_not_exists $APP_PATH

# Download pcloud app (delete any previous downloads)
eval "rm $FILE_COMPLETE_NAME*"
download_pcloud $FILE_DOWNLOAD_PATH $FILE_DOWNLOAD_NAME

if [ -e "$FILE_COMPLETE_NAME" ]; then
    mv $FILE_COMPLETE_NAME $APP_PATH
fi

if [ -e "$APP_PATH$FILE_DOWNLOAD_NAME" ]; then
    chmod 700 $APP_PATH$FILE_DOWNLOAD_NAME
    echo "Install of pcloud has completed"
else 
    echo "Install of pcloud has failed"
fi


