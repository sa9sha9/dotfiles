#!/usr/bin/env bash
DOT_DIR=${HOME}/git/dotfiles

# functions
exists() {
    command -v "$1" > /dev/null 2>&1
}
ask() {
  printf "$* [Y/n] "
  local answer
  read answer

  #todo: Yesをデフォルトにしたいな
  case $answer in
    "no" )  return 1 ;;
    "n"  )  return 1 ;;
    * )     return 0 ;;
  esac
}


# default
## gitディレクトリの作成
if [ ! -d $HOME/git ]; then
    echo $(tput setaf 2)START: mkdir ~/git $(tput sgr0)
    mkdir -p $HOME/git
fi

# Copy ./dotfiles to ${HOME}
echo $(tput setaf 2)START: put symlinks to ~/ $(tput sgr0)
SYMLINK_DIR=${HOME}/git/dotfiles/symlink
cd ${SYMLINK_DIR}
for f in .??*
do
    # 無視したいファイルやディレクトリはこんな風に追加してね
    #    [[ ${f} = ".git" ]] && continue
    #    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = "configs" ]] && continue

    #シンボリックリンクでdotfilesを管理すれば管理がシンプルになるね
    ### todo: ここでoverwriteの条件分岐を起こす必要があるかもしれない
    ln -snfv ${SYMLINK_DIR}/${f} ${HOME}/${f}
done
cd ${DOT_DIR}
echo $(tput setaf 2)"Deploy dotfiles complete!. ✔"$(tput sgr0)


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
    if [ ! -f "/usr/local/bin/zsh" ]; then
        echo $(tput setaf 4)"ERROR: brew-zsh does not installed!!"$(tput sgr0)
        exit 1
    fi
    sudo echo "/usr/local/bin/zsh" >> /etc/shells
    chsh -s $(which zsh)
    echo $(tput setaf 2)"Change shell complete. ✔"$(tput sgr0)
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
    curl -sL zplug.sh/installer | zsh  #this way is better than brew
    echo $(tput setaf 2)"'zplug' installation complete. ✔"$(tput sgr0)
else
    echo $(tput setaf 6)"WARNING: 'zplug' is already installed."$(tput sgr0)
fi

# SSH key
if ask "Do you want to create ssh key pair?"; then
    echo $(tput setaf 2)"START: make ssh key pair"$(tput sgr0)
    if [[ ! -d ${HOME}/.ssh ]]; then
        if exists "ssh-keygen"; then
            ssh-keygen -t rsa -C $(whoami) #comment: USER-NAME
            echo $(tput setaf 2)"make ssh key pair complete. ✔"$(tput sgr0)
        else
            echo $(tput setaf 6)"WARNING: 'ssh-keygen' does not installed."$(tput sgr0)
        fi
    fi
fi

