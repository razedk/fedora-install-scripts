#!/bin/bash

#
# This script sets up battery min/max charge threshold
#
# NOTE: Script is made for Fedora and might not work on other distributions
#
source config/common-config.sh
source util/print-util.sh

# Constants
START_THREADHOLD="75"
STOP_THREADHOLD="80"

#
# F U N C T I O N S   S E C T I O N
#



#
# M A I N   S E C T I O N
#

echo $START_THREADHOLD | sudo tee -a /sys/class/power_supply/BAT0/charge_control_start_threshold >/dev/null
echo $STOP_THREADHOLD | sudo tee -a  /sys/class/power_supply/BAT0/charge_control_end_threshold >/dev/null

echo $START_THREADHOLD | sudo tee -a /sys/class/power_supply/BAT0/charge_start_threshold >/dev/null
echo $STOP_THREADHOLD | sudo tee -a /sys/class/power_supply/BAT0/charge_stop_threshold >/dev/null
print_ok "Battery thresholds have been set. START=$START_THREADHOLD, STOP=$STOP_THREADHOLD"