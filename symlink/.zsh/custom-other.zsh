# カラー設定
export LSCOLORS=Gxfxcxdxbxegedabagacad

# vagrant
#export VAGRANT_HOME="/Volumes/PNCITY/.vagrant.d"

# exports
## sh
export PATH="${HOME}/sh:${PATH}"

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

# ローカルのセッティングファイルを読み込む
if [ -f ${HOME}/.zshrc.local ]; then
    source ${HOME}/.zshrc.local
fi

# exports
export PGDATA=/usr/local/var/postgres
