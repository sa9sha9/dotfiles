#!/usr/bin/env bash

# prepare util
DOTFILES_DIR=${HOME}/git/dotfiles
source ${DOTFILES_DIR}/util.sh

export DOTFILES_DIR
export SYMLINK_DIR=${DOTFILES_DIR}/symlink
export MACOS_DIR=${DOTFILES_DIR}/macos
export -f exists # export function
export -f ask   # export function


# Execute deployment or initialization depends on WHICH flag
case $(get_opt $@)  in
	deploy*) echo 'deploy enter'
			bash deploy.sh
			;;
	init*)   echo 'init enter'
			bash init.sh
			;;
	*)      echo 'all enter'
			bash deploy.sh
			bash init.sh
			;;
esac
