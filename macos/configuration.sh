#!/bin/bash
# functions for shell-script
exists() {
  command -v "$1" >/dev/null 2>&1
}
ask() {
  printf "$* [y/n] "
  local answer
  read answer

  case $answer in
    "yes" ) return 0 ;;
    "y" )   return 0 ;;
    * )     return 1 ;;
  esac
}

# brew cask
#if exist brew cask; then
#    brew cask install vagrant
#    brew cask install virtualbox
#    brew cask install sourcetree
#    brew cask install google-chrome
#    brew cask install sequel-pro
#    brew cask install iterm2
#    brew cask install vlc
#    brew cask install dash
#    brew cask isntall teamspeak-client
#    brew cask install teamviewer
#    brew cask install inkscape
#    brew cask install sketch
#    brew cask install eagle
#    brew cask install arduino
#    brew cask install processing
#    brew cask install mysqlworkbench
#    brew cask install docker
#    brew cask install brackets
#    brew cask install intellij-idea
#    brew cask install clion
#    brew cask install wireshark
#    brew cask install enpass
#    brew cask install google-photos-backup
#    brew cask install openoffice
#    brew cask install edgeview
#    brew cask install cheatsheet
#    brew cask install tunnelbear
#    brew cask install spotify
#    brew cask install karabiner-elements
#    brew cask install avast
#fi
#
## mas(AppStore)
#if exist mas; then
#    mas install 692867256 # Simplenote (1.1.7)
#    mas install 945689735 # Hash (1.0.2)
#    mas install 539883307 # LINE (4.11.1)
#    mas install 406056744 # Evernote (6.10)
#    mas install 425955336 # Skitch (2.7.8)
#    mas install 503039729 # Fotor Photo Editor (3.1.0)
#    mas install 668208984 # GIPHY CAPTURE (2.4)
##    mas install 965915283 # Go for Facebook (2.1)
#    mas install 566042322 # 123D Design (2.2.1)
#    mas install 497799835 # Xcode (8.2.1)
#    mas install 472226235 # LanScan (4.3)
#    mas install 803453959 # Slack (2.3.4)
#    mas install 507257563 #Sip (4.4.2)
#fi

### Installation(interactive) ###
BREWFILE_DIR=${DOT_DIRECTORY}/macos

# watch error && forbid undefined var
set -eu

if ask 'xcode install?'; then
  xcode-select --install
fi

if ask 'Homebrew install?'; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
  brew install caskroom/cask/brew-cask
fi

if ask 'execute brew bundle(Brewfile)?'; then
  brew tap Homebrew/bundle
  pushd $BREWFILE_DIR
  brew bundle -v # install all related with Homebrew using Brewfile
  popd
fi

#if ask 'restore setting from mackup? (need Dropbox directory)'; then
#  mackup restore
#fi

if ask "Do you want to install ruby by rbenv-rubybuild?"; then
  INSTALL_RUBY_VERSION="$( rbenv install -l | peco)"
  brew link readline --force
  MAKE_OPTS="-j 4" RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)" rbenv install $INSTALL_RUBY_VERSION
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

# @see https://discussionsjapan.apple.com/thread/10153604
#if ask 'set clamshell mode off? (for multi display sleep)'; then
#  sudo nvram boot-args="niog=1"
#fi


### crontab ###
# backup
#@daily cd $BREWFILE_DIR &&
#    brew brewdle dump --force &&
#    git add Brewfile &&
#    git commit -m "auto commit of Brewfile dump `date "+\%Y-\%m-\%d \%H:\%M:\%S"`" &&
#    git push
#
## update
#@weekly time nice -n19 brew update &&
#    time nice -n19 brew upgrade &&
#    time nice -n19 brew cleanup &&
#    for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || time nice -n19 brew cask install $c; done &&
#    time nice -n19 brew cask cleanup &&
#    for c in /opt/homebrew-cask/Caskroom/*; do vl=(`ls -t $c`) &&
#    for v in "${vl[@]:1}"; do \rm -rf "$c/$v"; done; done
#
