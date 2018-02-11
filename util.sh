#!/usr/bin/env bash
export DOTFILES_DIR=${HOME}/git/dotfiles
export SYMLINK_DIR=${DOTFILES_DIR}/symlink
export MACOS_DIR=${DOTFILES_DIR}/macos


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

export -f exists
export -f ask
export -f usage_exit
export -f get_opt