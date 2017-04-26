#!/usr/bin/env bash
# functions
exists() {
    command -v "$1" > /dev/null 2>&1
}

if ! exists "brew bundle"; then
    echo $(tput setaf 4)"ERROR: 'brew bundle' does not exists"$(tput sgr0)
    exit 1
fi

BREWFILE_DIR=${HOME}/git/dotfile/macos
cd ${BREWFILE_DIR}

brew bundle dump
