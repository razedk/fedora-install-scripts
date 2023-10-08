#!/bin/bash

file_util_create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

file_util_delete_create_dir() {
    if [ -d "$1" ]; then
        rm -rf "$1"
    fi
	mkdir -p "$1"
}

file_util_get_file_name() {
    echo "${1##*/}"
}

file_util_get_file_name_no_ext() {
    basename="${1##*/}"
	echo "${basename%%.*}"
}
