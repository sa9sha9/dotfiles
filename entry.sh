#!/usr/bin/env bash

# prepare util
DOTFILES_DIR=${HOME}/git/dotfiles
source ${DOTFILES_DIR}/util.sh


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
