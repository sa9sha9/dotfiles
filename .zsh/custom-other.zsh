#カラー設定
export LSCOLORS=Gxfxcxdxbxegedabagacad

#slacaenv(renvのscala版)
export PATH="${HOME}/.scalaenv/bin:${PATH}"
eval "$(scalaenv init -)"

#vagrant
export VAGRANT_HOME="/Volumes/PNCITY/.vagrant.d"

#sh
export PATH="${HOME}/sh:${PATH}"

#ディレクトリ変更時にls & iTermのタブ名を親+カレントに変更
function chpwd() { l; echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}