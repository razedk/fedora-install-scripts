#!/bin/bash

secure_boot_util_secure_boot_enabled() {
  sb_state=$(mokutil --sb-state)
  if [[ "$sb_state" == *"enabled"* ]]; then
    echo "true"
  else
    echo "false"
  fi
}

