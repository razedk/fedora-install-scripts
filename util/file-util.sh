#!/bin/bash

file_util_create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}


