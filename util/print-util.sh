#!/bin/bash

# Color codes to use with print command
RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'


print_error() {
    echo -e "${RED}ERROR: $1${RC}"
}

print_info() {
    echo -e "${YELLOW}$1${RC}"
}

print_ok() {
    echo -e "${GREEN}$1${RC}"
}
