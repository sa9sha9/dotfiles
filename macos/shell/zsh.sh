#!/usr/bin/env bash
source ${HOME}/git/dotfiles/common.sh

## Check zsh
if  ! exists zsh ; then
    echo $(tput setaf 4)"ERROR: 'zsh' doesn't installed!!"$(tput sgr0)
    brew install zsh
fi

# Install zprezto
function install_zprezto () {
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	setopt EXTENDED_GLOB
	for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md; do
		ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
	done
    ln -snfFv ${SYMLINK_DIR}/.zpreztorc ${HOME}/.zpreztorc
}
echo $(tput setaf 2)"START: Install 'zprezto'"$(tput sgr0)
if [[ ! -d ${HOME}/.zprezto ]]; then
	install_zprezto
else
	echo $(tput setaf 6)"WARNING: 'zprezto' is already installed."$(tput sgr0)
	if ask "Remove this?"; then
		rm -rf ${HOME}/.zprezto
	fi
	install_zprezto
fi
echo $(tput setaf 2)"'zprezto' installation complete. ✔"$(tput sgr0)

# reboot
source ${HOME}/.zshrc