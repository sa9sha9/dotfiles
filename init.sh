#!/usr/bin/env bash

# default
## gitディレクトリの作成
if [ ! -d $HOME/git ]; then
    mkdir -p $HOME/git
fi

# Copy ./dotfiles to ${HOME}
DOT_DIRECTORY=${HOME}/git/dotfiles
cd ${DOT_DIRECTORY}
for f in .??*
do
    # 無視したいファイルやディレクトリはこんな風に追加してね
    [[ ${f} = ".git" ]] && continue
    [[ ${f} = ".gitignore" ]] && continue

    #シンボリックリンクでdotfilesを管理すれば管理がシンプルになるね
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)


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
#todo: この時点できちんとbrew-zshがinstallされているかの検知
#todo: sudo権限が実行できるかどうかの検知

# shellsにbrew-zshを追加
sudo echo "/usr/local/bin/zsh" >> /etc/shells
# chsh
chsh -s /usr/local/bin/zsh

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
## 初期configファイルの生成(dotfilesのコピーで動かなかったらこれ実行)
#setopt EXTENDED_GLOB
#for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#done

# Install zplug
curl -sL zplug.sh/installer | zsh  #this way is better than brew



