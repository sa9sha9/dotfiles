#!/bin/bash

DOT_DIRECTORY=${HOME}/git/dotfiles

# functions for shell-script
exists() {
  command -v "$1" >/dev/null 2>&1
}
ask() {
  printf "$* [Y/n] "
  local answer
  read answer

  #todo: Yesをデフォルトにしたいな
  case $answer in
    "no" )  return 0 ;;
    "n"  )  return 0 ;;
    * )     return 1 ;;
  esac
}


### Installation(interactive) ###
MACOS_DIR=${DOT_DIRECTORY}/macos

# watch error && forbid undefined var
set -eu

## XCode
if ask 'xcode install?'; then
  xcode-select --install
fi

## Homebrew
if ask 'Homebrew install?'; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew install caskroom/cask/brew-cask
fi

## Homebrew bundle
if ask 'execute brew bundle(Brewfile)?'; then
  brew tap Homebrew/bundle
  pushd $MACOS_DIR
  brew bundle -v # install all related with Homebrew using Brewfile
  popd
fi

## Mackup
#if ask 'restore setting from mackup? (need Dropbox directory)'; then
#  mackup restore
#fi

### macOS setting @@@
## mac setting
if ask "set 'locate' command?"; then
  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
fi

if ask 'set visible dotfiles in finder?'; then
  defaults write com.apple.finder AppleShowAllFiles TRUE
  killall Finder
fi

if ask 'set fullpath title at finder?'; then
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool yes
  killall Finder
fi

if ask 'set always expand save dialog?'; then
  defaults write -g NSNavPanelExpandedStateForSaveMode -bool yes
fi

if ask 'set mute in mac booting sound?'; then
  sudo nvram SystemAudioVolume=%80
fi

if ask 'construct DAMP environment?'; then
  zsh $MACOS_DIR/forDAMP.sh
fi

# @see https://discussionsjapan.apple.com/thread/10153604
#if ask 'set clamshell mode off? (for multi display sleep)'; then
#  sudo nvram boot-args="niog=1"
#fi
