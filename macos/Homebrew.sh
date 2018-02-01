# following needs Homebrew
if ! exists brew; then
	echo $(tput setaf 4)"ERROR: You should install 'Homebrew' first."$(tput sgr0)
	exit 1 # back to parent process
fi

## Homebrew bundle
if ask 'execute brew bundle(Brewfile)?'; then
  brew tap Homebrew/bundle
  pushd ${MACOS_DIR}/configs
  brew bundle -v # install all related with Homebrew using Brewfile
  popd
fi