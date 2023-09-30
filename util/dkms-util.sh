#!/bin/bash

# Constants
KEYS_FOLDER="/var/lib/dkms"
PUBLIC_KEY_FILE="$KEYS_FOLDER/mok.pub"
PRIVATE_KEY_FILE="$KEYS_FOLDER/mok.key"


########################################################################################
# Public methods (always start with "dkms_util_")                                      #
########################################################################################

dkms_util_keys_exist() {
  if [[ -f $PUBLIC_KEY_FILE && -f $PRIVATE_KEY_FILE ]]; then
    echo "true"
  else
    echo "false"
  fi
}

dkms_util_is_dkms_signed() {
  local $module_name="$1"
  sign_result=$(modinfo $module_name | grep "signer")
  if [[ "$sign_result" == *"DKMS module signing key"* ]]; then
    echo "true"
  else
    echo "false"
  fi
}

dkms_util_enroll_key() {
    if [[ $(is_key_enrolled) == "false" ]]; then
        echo "DKMS signing key must be enrolled for Secure Boot to accept the module."
        echo "You will be asked to type in a password, you must remember this password since it is needed after next reboot."
        echo "After reboot a blue text based menu will appear."
        echo "You must select Enroll MOK and type in the password again. Then select Reboot to reboot."
        sudo mokutil --import $PUBLIC_KEY_FILE
        echo "Secure boot key has been enrolled. Please reboot."
    fi
}


########################################################################################
# Private methods (does not start with "dkms_util_")                                   #
########################################################################################

is_key_enrolled() {
  test_result=$(sudo mokutil --test-key $PUBLIC_KEY_FILE)
  if [[ "$test_result" == *"already enrolled"* ]]; then
    echo "true"
  else
    echo "false"
  fi
}

