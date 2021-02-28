#!/usr/bin/env bash
source ${HOME}/git/dotfiles/common.sh

# watch error && forbid undefined var
set -eu

# 今はzshのセットアップだけ
bash ${MACOS_DIR}/shell/zsh.sh