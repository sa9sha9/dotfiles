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

# getoptsでの引数判定.
# 引数に使いたいオプション文字列を列挙する.
# 文字の後に : をつけると引数を渡すことができて、$OPTARGに格納される.
# 先頭に : をつけると自動でエラー処理をしなくなる
while getopts ":he:" OPT
do
  case $OPT in
    e) WHICH=$OPTARG
	    ;;
    h) usage_exit
        ;;
    :) usage_exit
	    ;;
    \?) usage_exit
        ;;
  esac
done

# getopts分の引数値移動
shift $(($OPTIND - 1))


# Execute deployment or initialization depends on WHICH flag
case $WHICH in
	deploy) export SYMLINK_DIR=${DOTFILES_DIR}/symlink
			bash deploy.sh
			;;
	init)   export MACOS_DIR=${DOTFILES_DIR}/macos
			bash init.sh
			;;
	*)      export SYMLINK_DIR=${DOTFILES_DIR}/symlink
			export MACOS_DIR=${DOTFILES_DIR}/macos
			bash deploy.sh
			bash init.sh
			;;
esac
