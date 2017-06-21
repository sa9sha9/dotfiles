#!/usr/bin/env bash

# args
DOTFILES_DIR=${PWD} # => ~/git/dotfiles

# functions for shell-script
exists() {
  command -v "$1" >/dev/null 2>&1
}
ask() {
  printf "$* [y/N] "
  local answer
  read answer

  case $answer in
    "yes" )  return 0 ;;
    "y"   )  return 0 ;;
    * )     return 1 ;;
  esac
}

# usage when exit
usage_exit() {
        echo "Usage: $0 [-e (deploy/init)]" 1>&2
        exit 1
}

# Check arguments and Get the first argument
get_opt() {
    if [ $# -eq 1 ] ; then
        echo $1 #これが戻り値になる
        return 0
    else
		usage_exit
	fi
}


export DOTFILES_DIR
export -f exists # export function
export -f ask   # export function


# Execute deployment or initialization depends on WHICH flag
case $(get_opt $@)  in
	deploy) echo 'deploy enter'
			export SYMLINK_DIR=${DOTFILES_DIR}/symlink
			bash deploy.sh
			;;
	init)   echo 'init enter'
			export MACOS_DIR=${DOTFILES_DIR}/macos
			bash init.sh
			;;
	*)      echo 'all enter'
			export SYMLINK_DIR=${DOTFILES_DIR}/symlink
			export MACOS_DIR=${DOTFILES_DIR}/macos
			bash deploy.sh
			bash init.sh
			;;
esac
