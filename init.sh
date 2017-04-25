#!/usr/bin/env bash
DOT_DIR = ${HOME}/git/dotfiles

# functions
exists() {
    command -v "$1" > /dev/null 2>&1
}

# default
## gitディレクトリの作成
if [ ! -d $HOME/git ]; then
    mkdir -p $HOME/git
fi

# Copy ./dotfiles to ${HOME}
# todo: すでにリンクが貼られている場合についての処理
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
echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)

cd ${DOT_DIR}

# Working only OS X.
case ${OSTYPE} in
  darwin*)
    CONFIG_MACOS_DIR=${HOME}/git/dotfiles/macos
    bash $CONFIG_MACOS_DIR/configuration.sh
    ;;
  *)
    echo $(tput setaf 1)Working only OS X!!$(tput sgr0)
    exit 1
    ;;
esac


## 以降の処理にはzshのインストールが先 ##
if [ ! -f "/usr/local/bin/zsh" ]; then
    echo "brew-zsh does not installed!!"
    exit 1
fi
#todo: sudo権限が実行できるかどうかの検知

# shellsにbrew-zshを追加
# issue: ここがうまくいかない。itermの設定で起動時shellをzshに変更しようか
sudo echo "/usr/local/bin/zsh" >> /etc/shells
# chsh
chsh -s $(which zsh)

# Install prezto
if [[ ! -d ${HOME}/.zprezto ]]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
    echo "WARNING: zprezto is already installed."
fi
## 初期configファイルの生成(dotfilesのコピーで動かなかったらこれ実行)
#setopt EXTENDED_GLOB
#for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#done
    

# Install zplug
if [[ ! -d ${HOME}/.zplug ]]; then
    curl -sL zplug.sh/installer | zsh  #this way is better than brew
else
    echo "WARNING: zplug is already installed."
fi

# ssh
if [[ ! -d ${HOME}/.ssh ]]; then
    if exists "ssh-keygen"; then
	ssh-keygen -t rsa -C $(whoami) #comment: USER-NAME
    else
	echo "ERROR: 'ssh-keygen' does not installed"
    fi
fi
