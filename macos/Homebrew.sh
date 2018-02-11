# prepare util
DOTFILES_DIR=${HOME}/git/dotfiles
source ${DOTFILES_DIR}/util.sh

# following needs Homebrew
if ! exists brew; then
	echo $(tput setaf 4)"ERROR: You should install 'Homebrew' first."$(tput sgr0)
	exit 1 # back to parent process
fi

## Homebrew bundle
brew tap Homebrew/bundle
pushd ${MACOS_DIR}/configs
brew bundle -v # install all related with Homebrew using Brewfile
popd



# Install docker app
if [[ ! -x /Applications/Backup\ and\ Sync\ from\ Google.app ]]; then
	brew cask install google-backup-and-sync
fi

/usr/bin/osascript -e 'display notification "Opening BackupAndSync.app and you SHOULD DO some operations." with title "App"'
open -a Backup\ and\ Sync.app

# Setting up Library
# it needs GoogleDrive Sync
/usr/bin/osascript -e 'display notification "Set up Library?" with title "Asking"'
if ask "Set up Library?"; then
	bash ${MACOS_DIR}/Library.sh
fi