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
    bash ${MACOS_DIR}/setup.sh
    ;;
  *)
    echo $(tput setaf 4)"ERROR: Working only OS X!!"$(tput sgr0)
    exit 1
    ;;
esac
echo $(tput setaf 2)"Configuration complete. ✔"$(tput sgr0)
/usr/bin/osascript -e 'display notification "Successfully complete configuration" with title "Success"'

