# List directory contents
# A:except ".." & ".", G:colorize, F:classify,
# l:long style, a:all, h:human unit style,
alias ls='ls -GF'
alias la='ls -aGF'
alias ll='ls -lhGFA'
alias l='ls -lahGFA'
alias sshaizu='sh ${HOME}/sh/sshaizu'
alias sftpaizu='sh ${HOME}/sh/sftpaizu'
alias yafcaizu='sh ${HOME}/sh/yafcaizu'
alias dirs='dirs -v'
alias git=hub
alias relogin='exec $SHELL -l'
alias o='open ./$@'
alias f='fzf $@'

# git
alias gmch='git commit --allow-empty -m "init commit for story [branch ch30]"'

# mysql
## -S: 折り返しなし
## -n: 行番号を表示しない
## -i: case insensitive
## -F: 一画面で全て表示した場合、lessを終了
## -X: 端末にtermcap初期化文字、非初期化文字を送らない
alias mysql="mysql --pager='less -S -n -i -F -X'"
#function mysql() { mysql $@ --pager'less -SniFX' }

# docker
alias dck=docker
alias dckc='docker-compose'
alias dckm='docker-machine'
alias dck-ps='docker ps'
alias dck-psa='docker ps -a'
function dck-rma() { docker rm $@ $(docker ps -a -q) }
function dckc-u() { docker-compose up $@ }

# CircleCI
alias ci=circleci

# Idea
alias idea="open -a /Applications/IntelliJ\ IDEA.app $@"

# truffle
alias trf=truffle

# gatsbyJS
alias gats=gatsby

# util
alias relogin='exec $SHELL -l'

# macos
alias o='open ./$@'
alias chrome='open -a "Google Chrome" $@'

# function
# cd to the path of the front Finder window (like cdto..)
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

# every
alias ssh-dev-lithium='ssh -i ~/.ssh/id_rsa -l siukaido ec2-13-230-27-147.ap-northeast-1.compute.amazonaws.com -p 50022'
alias ssh-lithium='ssh -i ~/.ssh/id_rsa -l siukaido lithium.mamadays.tv -p 50022'

# laravel
alias lrvl="laravel"