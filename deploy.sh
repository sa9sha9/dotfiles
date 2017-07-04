#!/usr/bin/env bash

pushd ${SYMLINK_DIR}

# Copy ./dotfiles to ${HOME}
echo $(tput setaf 2)"START: put symlinks to ~/ "$(tput sgr0)

# ファイル名が2文字以上のドットファイルをシムリンク(.や..を省く)
for f in .??*
do
    # 無視したいファイルやディレクトリはこんな風に追加してね
    #    [[ ${f} = ".git" ]] && continue
    #    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = ".DS_Store" ]] && continue

    # -n: overwrite symlink of directory, -f: overwrite symlink of file
    ln -snfv ${SYMLINK_DIR}/${f} ${HOME}/${f}
done

# '.' から始まらないファイルたちのシムリンク
for f in *
do
    ln -snfv ${SYMLINK_DIR}/${f} ${HOME}/${f}
done

echo $(tput setaf 2)"Deploy dotfiles complete!. ✔"$(tput sgr0)
popd # cd back to ${DOTFILES_DIR}

