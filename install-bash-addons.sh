#!/bin/bash

#
# This scripts downloads and installs starship cross-shell prompt
#
# NOTE: Script is made for Fedora and might not work on other distributions
#

source config/common-config.sh
source util/print-util.sh
source util/file-util.sh

#
# F U N C T I O N S   S E C T I O N
#

INSTALL_PATH="install-bash-addons"


command_exists () {
    command -v $1 >/dev/null 2>&1;
}

installDepend() {
    # Check for dependencies.
    print_info "Installing dependencies..."
    sudo dnf install -yq autojump bash bash-completion tar bat
}

installStarship() {
    if command_exists starship; then
        print_ok "Starship already installed"
        return
    fi

    if ! curl -sS https://starship.rs/install.sh|sh;then
        print_error "Something went wrong during starship install!"
        exit 1
    fi
}

installConfig() {
    # Create target directories if not already exist
    file_util_create_dir ${BASHRC_DIR}
    file_util_create_dir ${CONFIG_DIR}
   
    print_info "Copying config files (${INSTALL_PATH})..."
    cp -a ${INSTALL_PATH}/.bashrc.d ${HOME}/
    cp ${INSTALL_PATH}/starship.toml ${CONFIG_DIR}/
}

installNerdFonts() {
	FONT_SOURCE_DIR="${INSTALL_PATH}/fonts"
	FONT_TARGET_DIR="${LOCAL_SHARE_DIR}/fonts"
	FILE_EXT=".zip"

    for file in $FONT_SOURCE_DIR/*$FILE_EXT ;
    do
		font_folder_name=$(basename $file $FILE_EXT)
		print_info "Path=${file}, FontFolder=${font_folder_name}"
  	    file_util_delete_create_dir ${FONT_TARGET_DIR}/${font_folder_name}
		unzip -d ${FONT_TARGET_DIR}/${font_folder_name} $file
    done
	
	fc-cache -fv
}

#
# M A I N   S E C T I O N
#

installDepend
installStarship
installConfig
installNerdFonts

print_ok "Done!\nrestart your shell to see the changes."

