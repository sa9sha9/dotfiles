#!/usr/bin/env bash

# prepare util
DOTFILES_DIR=${HOME}/git/dotfiles
source ${DOTFILES_DIR}/util.sh

# watch error && forbid undefined var
set -eu

## XCode
if ask 'xcode install?'; then
  xcode-select --install
fi

### macOS setting @@@
## mac setting
if ask "set 'locate' command?"; then
  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
fi

if ask 'set visible dotfiles in finder?'; then
  defaults write com.apple.finder AppleShowAllFiles TRUE
  killall Finder
fi

if ask 'would not make .DS_Store?'; then
    defaults write com.apple.desktopservices DSDontWriteNetworkStores true
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

if ask 'set "~/Downloads" as default location of screen capture?'; then
  defaults write com.apple.screencapture location ~/Downloads/ScreenShots
fi

# @see https://discussionsjapan.apple.com/thread/10153604
#if ask 'set clamshell mode off? (for multi display sleep)'; then
#  sudo nvram boot-args="niog=1"
#fi



# install Homebrew
if ! exist brew; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	echo $(tput setaf 2)"START: brew doctor"$(tput sgr0)
	brew doctor
fi


# todo: すべてforkで子プロセスに切り替える
## Homebrew Bundle
# if ask 'Homebrew Bundle?'; then
#   bash ${MACOS_DIR}/Homebrew.sh
# fi

## Docker
# if ask 'DAMP environment?'; then
#   bash ${MACOS_DIR}/DAMP.sh
# fi

## Shell
if ask 'Shell framework install?'; then
    bash ${MACOS_DIR}/Shell.sh
fi

# fzf
git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# goenv
git clone https://github.com/syndbg/goenv.git ~/.goenv