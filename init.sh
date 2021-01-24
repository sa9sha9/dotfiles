#!/usr/bin/env bash
function prepare () {
  # Could be asked to install X-Code for macos

  # gitディレクトリの作成
  if [ ! -d $HOME/git ]; then
      echo $(tput setaf 2)"START: mkdir ~/git"$(tput sgr0)
      mkdir -p $HOME/git
  fi

  # clone dotfiles
  if [ ! -d ${HOME}/git/dotfiles ];then
      cd ${HOME}/git
      git clone https://github.com/sa9sha9/dotfiles.git
  fi

  source ${HOME}/git/dotfiles/common.sh
}

function main () {
  printf "What will do? [ (set)up/ (sym)link / (*)both]: "
  local answer
  read answer

  case $answer in
    sym*) echo 'run symlink'
        symlink
        ;;
    set*) echo 'run setup'
        setup
        ;;
    *)  echo 'run symlink & setup'
        symlink
        setup
        ;;
  esac
}

# add symlink
function symlink () {
  pushd ${SYMLINK_DIR}
  echo $(tput setaf 2)"START: put symlinks to ~/ "$(tput sgr0)

  # ファイル名が2文字以上のドットファイルをシムリンク(.や..を省く)
  for f in .??*
  do
    # 無視したいファイルやディレクトリはこんな風に追加してね
    [[ ${f} = ".DS_Store" ]] && continue
    # -n: overwrite symlink of directory, -f: overwrite symlink of file
    ln -snfFv ${SYMLINK_DIR}/${f} ${HOME}/${f}
  done

  # '.' から始まらないファイルたちのシムリンク
  for f in *
  do
    ln -snfFv ${SYMLINK_DIR}/${f} ${HOME}/${f}
  done

  echo $(tput setaf 2)"Deploy dotfiles complete!. ✔"$(tput sgr0)
  popd
}

# setup system
function setup () {
  # Configuration for MacOS
  case ${OSTYPE} in
    darwin*)
      echo $(tput setaf 2)"START: setup for macOS"$(tput sgr0)
      bash ${MACOS_DIR}/setup.sh
      ;;
    *)
      echo $(tput setaf 4)"ERROR: Working only OS X!!"$(tput sgr0)
      exit 1
      ;;
  esac
  echo $(tput setaf 2)"setup complete. ✔"$(tput sgr0)
  /usr/bin/osascript -e 'display notification "Successfully complete setup" with title "Success"'
}

# run
prepare
main