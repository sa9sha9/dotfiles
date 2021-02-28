#!/usr/bin/env bash
source ${HOME}/git/dotfiles/common.sh

# watch error && forbid undefined var
set -eu

### macOS setting @@@
## mac setting

# Capture loaction
echo $(tput setaf 2)"Set capture location to ~/Downloads/ScreenShots "$(tput sgr0)
if [ ! -d ${HOME}/Downloads/ScreenShots ]; then
  mkdir ${HOME}/Downloads/ScreenShots
fi
defaults write com.apple.screencapture location ${HOME}/Downloads/ScreenShots

echo $(tput setaf 2)"Set `locate` command "$(tput sgr0)
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

echo $(tput setaf 2)"Set dotfiles visible "$(tput sgr0)
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder

echo $(tput setaf 2)"Don't make .DS_Store "$(tput sgr0)
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

echo $(tput setaf 2)"Show fullpath title in finder "$(tput sgr0)
defaults write com.apple.finder _FXShowPosixPathInTitle -bool yes
killall Finder

echo $(tput setaf 2)"Set always expand save dialog "$(tput sgr0)
defaults write -g NSNavPanelExpandedStateForSaveMode -bool yes

# Install Homebrew
if ! exist brew; then
	echo $(tput setaf 2)"Install Homebrew "$(tput sgr0)
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Shell
echo $(tput setaf 2)"Setup shell framework "$(tput sgr0)
bash ${MACOS_DIR}/setup_shell.sh

# Install fzf
if [[ ! -d ${HOME}/.fzf ]]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
fi

# goenv
if [[ ! -d ${HOME}/.goenv ]]; then
  git clone https://github.com/syndbg/goenv.git ~/.goenv
fi

if [[ ! -d ${HOME}/.anyenv ]]; then
 git clone https://github.com/anyenv/anyenv ~/.anyenv
 ~/.anyenv/bin/anyenv init
 ~/.anyenv/bin/anyenv install --init
 ~/.anyenv/bin/anyenv install nodenv
 ~/.anyenv/bin/anyenv install goenv
 ~/.anyenv/bin/anyenv install pyenv
 ~/.anyenv/bin/anyenv install phpenv
fi

# brew bundle
echo $(tput setaf 2)"Run `brew bundle --global` if you need "$(tput sgr0)

# fonts
echo $(tput setaf 2)"You should get `fonts` from Google Drive "$(tput sgr0)