#!/usr/bin/env bash
# default
## gitディレクトリの作成
if [ ! -d $HOME/git ]; then
    echo $(tput setaf 2)"START: mkdir ~/git"$(tput sgr0)
    mkdir -p $HOME/git
fi

# clone dotfiles
if [ ! -d ${HOME}/git/dotfiles ];then
    cd ${HOME}/git
    git clone https://github.com/sak39/dotfiles.git
fi


# git config
git config --global user.name ${USER}
git config --global user.email ${USER}@gmail.com #todo
git config --global push.default current
git config --global core.excludesfile ${HOME}/.gitignore_global
## sourcetreeがインストールされている場合のみ
if [ -d /Applications/SourceTree.app ]; then
	git config --global commit.template ${HOME}/.stCommitMsg
fi


# Configuration for MacOS
case ${OSTYPE} in
  darwin*)
    echo $(tput setaf 2)"START: configuration for macOS"$(tput sgr0)
    bash ${MACOS_DIR}/configuration.sh
    ;;
  *)
    echo $(tput setaf 4)"ERROR: Working only OS X!!"$(tput sgr0)
    exit 1
    ;;
esac
echo $(tput setaf 2)"Configuration complete. ✔"$(tput sgr0)


## following needs ZSH
if  ! exists zsh ; then
    echo $(tput setaf 4)"ERROR: 'zsh' doesn't installed!!"$(tput sgr0)
    brew install zsh
fi

# set zsh as default shell
if ask "set default shell with '/usr/local/bin/zsh' ?"; then
    echo $(tput setaf 2)"START: chsh -s /usr/local/bin/zsh"$(tput sgr0)
    BREW_ZSH_LOCATION=$(which zsh)
    echo $(tput setaf 1)"DEBUG: ${BREW_ZSH_LOCATION}"$(tput sgr0) #@@
    if [ ${BREW_ZSH_LOCATION} != "/usr/local/bin/zsh" ]; then
        echo $(tput setaf 4)"ERROR: brew-zsh does not installed!!"$(tput sgr0)
        brew install zsh
    fi

    sudo sh -c "echo ${BREW_ZSH_LOCATION} >> /etc/shells"
    # If it writes into /etc/shells successfully
    if [ $? -eq "0" ]; then
        chsh -s ${BREW_ZSH_LOCATION}
        echo $(tput setaf 2)"Change shell complete. ✔"$(tput sgr0)
        echo $(tput setaf 2)"But.. 'chsh: no changes made' appears in there. In this case, you can change your shell at SystemPreference/User&Groups/AdvancedOptions."$(tput sgr0)
    else
        echo $(tput setaf 6)"WARNING: Failed writing into /etc/shells"$(tput sgr0)
    fi
fi


# ohmyzsh? prezto?
ask_framework() {
  printf "$* [o(h-my-zsh)/P(rezto)] "
  local answer
  read answer

  case $answer in
    o*   )  return 0 ;;
    p*   )  return 1 ;;
    *    )  return 1 ;;
  esac
}

## Install prezto
#if [[ ! -d ${HOME}/.zprezto ]]; then
#    echo $(tput setaf 2)"START: Install 'zprezto'"$(tput sgr0)
#    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
#    echo $(tput setaf 2)"'zprezto' installation complete. ✔"$(tput sgr0)
#else
#    echo $(tput setaf 6)"WARNING: 'zprezto' is already installed."$(tput sgr0)
#fi

## Install zplug
#if [[ ! -d ${HOME}/.zplug ]]; then
#    echo $(tput setaf 2)"START: Install 'zplug'"$(tput sgr0)
#  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
#    echo $(tput setaf 2)"'zplug' installation complete. ✔"$(tput sgr0)
#else
#    echo $(tput setaf 6)"WARNING: 'zplug' is already installed."$(tput sgr0)
#fi

# Install Oh-my-zsh
if ask "Install oh-my-zsh?"; then
	echo $(tput setaf 2)"START: Install 'oh-my-zsh'"$(tput sgr0)
	if [[ -d ${HOME}/.oh-my-zsh ]]; then
	    # If ohmyzsh already installed, remove .oh-my-zsh directory first
		echo $(tput setaf 6)"Removing .oh-my-zsh..."$(tput sgr0)
	    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	    ln -snfv ${SYMLINK_DIR}/.zshrc.ohmyzsh ${HOME}/.zshrc
		# zsh-sytax-hightlightingの設定
	    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/.oh-my-zsh/plugins/zsh-syntax-highlighting
	else
	    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	    ln -snfv ${SYMLINK_DIR}/.zshrc.ohmyzsh ${HOME}/.zshrc
	    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/.oh-my-zsh/plugins/zsh-syntax-highlighting
	fi
	echo $(tput setaf 2)"'oh-my-zsh' installation complete. ✔"$(tput sgr0)
fi

# SSH key
if ask "Do you want to create ssh key pair?"; then
    echo $(tput setaf 2)"START: make ssh key pair"$(tput sgr0)
    if exists "ssh-keygen"; then
        ssh-keygen -t rsa -C $(whoami) #comment: USER-NAME
        echo $(tput setaf 2)"make ssh key pair complete. ✔"$(tput sgr0)
    else
        echo $(tput setaf 6)"WARNING: 'ssh-keygen' does not installed."$(tput sgr0)
    fi
fi

