#!/bin/bash

DOT_DIRECTORY="${HOME}/git/dotfiles"
# DOT_TARBALL="https://github.com/sak39/dotfiles/tarball/master"
DOT_FILES="https://github.com/sak39/dotfiles"
REMOTE_URL="git@github.com:sak39/dotfiles.git"

# ディレクトリがなければダウンロード（と解凍）する
if [ ! -d ${DOT_DIRECTORY} ]; then
  echo "Downloading dotfiles..."
  mkdir ${DOT_DIRECTORY}

  if type "git" > /dev/null 2>&1; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    curl -fsSLo ${HOME}/git/dotfiles ${DOT_FILES}
# TAR_BALLを使う場合
#    curl -fsSLo ${HOME}/git/dotfiles.tar.gz ${DOT_TARBALL}
#    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
#    rm -f ${HOME}/git/dotfiles.tar.gz
  fi

  echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
fi