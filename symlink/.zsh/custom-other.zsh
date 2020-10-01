# zsh
export ZDOTDIR=$HOME/.zsh

# カラー設定
export LSCOLORS=Gxfxcxdxbxegedabagacad

# vagrant
#export VAGRANT_HOME="/Volumes/PNCITY/.vagrant.d"

# PATH
## sh
export PATH="${HOME}/sh:${PATH}"
## brew sbin
export PATH="/usr/local/sbin:$PATH"
## fastlane
export PATH="$HOME/.fastlane/bin:$PATH"
## npm bin
export PATH=$PATH:`npm bin -g`
## go
export PATH="$HOME/go/bin:$PATH"
## goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
# rust
export PATH="$HOME/.cargo/bin:$PATH"


# Custom functions
source ${HOME}/.zsh/custom-functions.zsh
# ディレクトリ変更時にls & iTermのタブ名を親+カレントに変更
function chpwd() { l; echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}

## zsh-history
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=5000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# スペースから始まるものを記録しない
setopt hist_ignore_space
# historyを呼び出してから一旦編集可能
setopt hist_verify
# 冗長な空白は詰める
setopt hist_reduce_blanks
# historyコマンドを記録しない
setopt hist_no_store
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward


## その他
# Ctrl+w(行頭まで削除)で､直前の/までを削除する
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# postgres
export PGDATA=/usr/local/var/postgres

# pynev
if type "pyenv" > /dev/null 2>&1; then
   eval "$(pyenv init -)"
fi

# nodenv
eval "$(nodenv init -)"

# goenv
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
