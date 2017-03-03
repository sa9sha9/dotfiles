exist() {
    command -v "$1" >/dev/null 2>&1
}

# brew cask
if exist brew cask; then
    brew cask install vagrant
    brew cask install virtualbox
    brew cask install sourcetree
    brew cask install google-chrome
    brew cask install iterm2
    brew cask install vlc
    brew cask install dash
    brew cask install teamspeak-client
    brew cask install teamviewer
    brew cask install xquartz
    brew cask install inkscape # it needs 'xquartz'
    brew cask install sketch
    brew cask install eagle
    brew cask install arduino
    brew cask install processing
    brew cask install mysqlworkbench
    brew cask install docker
    brew cask install brackets
    brew cask install intellij-idea
    brew cask install clion
    brew cask install wireshark
    brew cask install enpass
    brew cask install google-photos-backup
    brew cask install openoffice
    brew cask install edgeview
    brew cask install cheatsheet
    brew cask install tunnelbear
    brew cask install spotify
    brew cask install karabiner-elements
    brew cask install avast
fi

# mas(AppStore)
if exist mas; then
    mas install 692867256 # Simplenote (1.1.7)
    mas install 945689735 # Hash (1.0.2)
    mas install 539883307 # LINE (4.11.1)
    mas install 406056744 # Evernote (6.10)
    mas install 425955336 # Skitch (2.7.8)
    mas install 503039729 # Fotor Photo Editor (3.1.0)
    mas install 668208984 # GIPHY CAPTURE (2.4)
    mas install 566042322 # 123D Design (2.2.1)
    mas install 497799835 # Xcode (8.2.1)
    mas install 472226235 # LanScan (4.3)
    mas install 803453959 # Slack (2.3.4)
    mas install 507257563 #Sip (4.4.2)
fi
