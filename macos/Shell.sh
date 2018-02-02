if ! exists fish ; then
    brew install fish
fi

# set fish as default shell
if ask "Set default shell with '/usr/local/bin/fish' ?"; then
    echo $(tput setaf 2)"START: chsh -s /usr/local/bin/fish"$(tput sgr0)
    BREW_FISH_LOCATION=$(which fish)
    if [ ${BREW_FISH_LOCATION} != "/usr/local/bin/fish" ]; then
        echo $(tput setaf 4)"ERROR: brew-fish does not installed!!"$(tput sgr0)
        brew install fish
    fi

    /usr/bin/osascript -e 'display notification "Please input password" with title "Password Required"'
    sudo sh -c "echo ${BREW_FISH_LOCATION} >> /etc/shells"
    # If it writes into /etc/shells successfully
    if [ $? -eq "0" ]; then
        chsh -s ${BREW_FISH_LOCATION}
        echo $(tput setaf 2)"Change shell complete. ✔"$(tput sgr0)
    else
        echo $(tput setaf 6)"WARNING: Failed writing into /etc/shells"$(tput sgr0)
    fi
fi

exit 0

## following needs ZSH
if  ! exists zsh ; then
    echo $(tput setaf 4)"ERROR: 'zsh' doesn't installed!!"$(tput sgr0)
    brew install zsh
fi

# set zsh as default shell
if ask "set default shell with '/usr/local/bin/zsh' ?"; then
    echo $(tput setaf 2)"START: chsh -s /usr/local/bin/zsh"$(tput sgr0)
    BREW_ZSH_LOCATION=$(which zsh)
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
		  echo $(tput setaf 6)"Removing .oh-my-zsh..."$(tput sgr0)
      rm -rf ${HOME}/.oh-my-zsh
  fi
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # zsh-sytax-hightlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/.oh-my-zsh/plugins/zsh-syntax-highlighting
	fi
	echo $(tput setaf 2)"'oh-my-zsh' installation complete. ✔"$(tput sgr0)
fi
