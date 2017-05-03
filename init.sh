#!/usr/bin/env bash
# functions
exists() {
    command -v "$1" > /dev/null 2>&1
}
ask() {
  printf "$* [y/N] "
  local answer
  read answer

  case $answer in
    "yes" )  return 0 ;;
    "y"   )  return 0 ;;
    * )     return 1 ;;
  esac
}


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

DOT_DIR=${HOME}/git/dotfiles

# Copy ./dotfiles to ${HOME}
echo $(tput setaf 2)"START: put symlinks to ~/ "$(tput sgr0)
SYMLINK_DIR=${HOME}/git/dotfiles/symlink
cd ${SYMLINK_DIR}
for f in .??*
do
    # 無視したいファイルやディレクトリはこんな風に追加してね
    #    [[ ${f} = ".git" ]] && continue
    #    [[ ${f} = ".gitignore" ]] && continue

    # -n: overwrite symlink of directory, -f: overwrite symlink of file
    ln -snfv ${SYMLINK_DIR}/${f} ${HOME}/${f}
done
cd ${DOT_DIR}
echo $(tput setaf 2)"Deploy dotfiles complete!. ✔"$(tput sgr0)

# git config
git config --global user.name ${USER}
git config --global user.email ${USER}@gmail.com #todo
git config --global commit.template ${HOME}/.stCommitMsg
git config --global core.excludesfile ${USER}/.gitignore_global

# Configuration for MacOS
case ${OSTYPE} in
  darwin*)
    echo $(tput setaf 2)"START: configuration for macOS"$(tput sgr0)
    CONFIG_MACOS_DIR=${HOME}/git/dotfiles/macos
    bash ${CONFIG_MACOS_DIR}/configuration.sh
    ;;
  *)
    echo $(tput setaf 4)"ERROR: Working only OS X!!"$(tput sgr0)
    exit 1
    ;;
esac
echo $(tput setaf 2)"Configuration complete. ✔"$(tput sgr0)


## 以降の処理にはzshのインストールが先 ##
if ask "set default shell to '/usr/local/bin/zsh' ?"; then
    echo $(tput setaf 2)"START: chsh -s /usr/local/bin/zsh"$(tput sgr0)
    BREW_ZSH_LOCATION=$(which zsh)
    echo $(tput setaf 1)"DEBUG: ${BREW_ZSH_LOCATION}"$(tput sgr0) #@@
    if [ ${BREW_ZSH_LOCATION} != "/usr/local/bin/zsh" ]; then
        echo $(tput setaf 4)"ERROR: brew-zsh does not installed!!"$(tput sgr0)
        exit 1
    fi
#    if [ ! -f "/usr/local/bin/zsh" ]; then
#        echo $(tput setaf 4)"ERROR: brew-zsh does not installed!!"$(tput sgr0)
#        exit 1
#    fi

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

# normal-zsh are installed?
if  ! exists zsh ; then
    echo $(tput setaf 4)"ERROR: 'zsh' doesn't installed!!"$(tput sgr0)
    exit 1
fi

# Install prezto
if [[ ! -d ${HOME}/.zprezto ]]; then
    echo $(tput setaf 2)"START: Install 'zprezto'"$(tput sgr0)
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    echo $(tput setaf 2)"'zprezto' installation complete. ✔"$(tput sgr0)
else
    echo $(tput setaf 6)"WARNING: 'zprezto' is already installed."$(tput sgr0)
fi

# Install zplug
if [[ ! -d ${HOME}/.zplug ]]; then
    echo $(tput setaf 2)"START: Install 'zplug'"$(tput sgr0)
    curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
    echo $(tput setaf 2)"'zplug' installation complete. ✔"$(tput sgr0)
else
    echo $(tput setaf 6)"WARNING: 'zplug' is already installed."$(tput sgr0)
fi

# SSH key
if ask "Do you want to create ssh key pair?"; then
    # todo: .ssh directoryがない状態でのssh-keygenがどのような挙動をするのかを調べる
    echo $(tput setaf 2)"START: make ssh key pair"$(tput sgr0)
    if exists "ssh-keygen"; then
        ssh-keygen -t rsa -C $(whoami) #comment: USER-NAME
        echo $(tput setaf 2)"make ssh key pair complete. ✔"$(tput sgr0)
    else
        echo $(tput setaf 6)"WARNING: 'ssh-keygen' does not installed."$(tput sgr0)
    fi
fi

