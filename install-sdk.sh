#!/bin/bash

#
# This scripts downloads and install pCloud
#
# NOTE: Script is made for Fedora and might not work on other distributions
#

source util/print-util.sh
source util/file-util.sh

#
# F U N C T I O N S   S E C T I O N
#


#
# M A I N   S E C T I O N
#

# Install SDK
curl -s "https://get.sdkman.io" | bash
print_ok "Install of SDK man has completed"


