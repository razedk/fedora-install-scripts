#!/bin/bash

#
# This script install basic apps from fedora, rpmfusion and flathub
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
    sudo dnf groupinstall -y 	"Development Tools"    				

    sudo dnf install -y 	gnome-tweaks \
    				dconf-editor \
    				vlc \
    				wine \
    				meld \
    				qbittorrent \
    				qemu \
    				virt-manager \
    				rapidsvn \
    				git-credential-libsecret
    				
    print_info "Finished installing DNF packages"
}

install_flatpak_repos() {
    # From Fedora 39 flathub is already included
    #flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    print_info "No repos to install, moving on..." 
}

install_flatpak_packages() {
    # Fedora flatpaks
    # flatpak install fedora
    
    # Flathub flatpaks
    flatpak install flathub -y	org.keepassxc.KeePassXC \
				com.adobe.Reader \
				com.github.dail8859.NotepadNext \
				com.mattjakeman.ExtensionManager \
				com.opera.Opera \
				com.github.IsmaelMartinez.teams_for_linux \
				io.github.mimbrero.WhatsAppDesktop \
				com.skype.Client \
				com.github.alexkdeveloper.desktop-files-creator \
				com.jgraph.drawio.desktop \
				com.axosoft.GitKraken \
				com.gitfiend.GitFiend \
				com.github.git_cola.git-cola \
				com.jetbrains.IntelliJ-IDEA-Community \
				org.eclipse.Java \
				com.visualstudio.code
}



#
# M A I N   S E C T I O N
#

install_dnf_repos
install_dnf_packages
install_flatpak_repos
install_flatpak_packages

print_ok "Install of apps has completed"
    
  
