#!/bin/bash

#
# This scripts install basic apps from fedora, rpmfusion and flathub
#
# NOTE: Script is made for Fedora and might not work on other distributions
#

source util/print-util.sh

#
# F U N C T I O N S   S E C T I O N
#

install_dnf_repos() {
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

install_dnf_packages() {
    print_info "Installing DNF packages"
    sudo dnf install -y gnome-tweaks dconf-editor vlc wine meld qbittorrent
    print_info "Finished installing DNF packages"
}

install_flatpak_repos() {
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

install_flatpak_packages() {
    # Fedora flatpaks
    flatpak install fedora
    
    # Flathub flatpaks
    flatpak install flathub "Adobe Reader" Opera teams-for-linux "Desktop Files Creator" "WhatsApp for Linux"
    
    # Devel
    # GitKraken, Postman, Git Cola  
}



#
# M A I N   S E C T I O N
#

install_dnf_repos
install_dnf_packages
install_flatpak_repos
install_flatpak_packages

print_ok "Install of apps has completed"
    
  
