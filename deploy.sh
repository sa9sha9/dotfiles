#!/usr/bin/env bash

# Copy ./dotfiles to ${HOME}
echo $(tput setaf 2)"START: put symlinks to ~/ "$(tput sgr0)

pushd ${SYMLINK_DIR}

for f in .??*
do
    # 無視したいファイルやディレクトリはこんな風に追加してね
    #    [[ ${f} = ".git" ]] && continue
    #    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = ".DS_Store" ]] && continue

    # -n: overwrite symlink of directory, -f: overwrite symlink of file
    ln -snfv ${SYMLINK_DIR}/${f} ${HOME}/${f}
done
echo $(tput setaf 2)"Deploy dotfiles complete!. ✔"$(tput sgr0)

popd # cd back to ${DOTFILES_DIR}

