# List directory contents
# A:except ".." & ".", G:colorize, F:classify,
# l:long style, a:all, h:human unit style,
abbr --add ls 'ls -GF'
abbr --add la 'ls -aGF'
abbr --add ll 'ls -lhGFA'
abbr --add l 'ls -lahGFA'
abbr --add sshaizu 'sh ${HOME}/sh/sshaizu'
abbr --add sftpaizu 'sh ${HOME}/sh/sftpaizu'
abbr --add yafcaizu 'sh ${HOME}/sh/yafcaizu'
abbr --add dirs 'dirs -v'
abbr --add git hub
abbr --add relogin 'exec $SHELL -l'
abbr --add f 'fzf'

# git
abbr --add gmch 'git commit --allow-empty -m "init commit for story [branch ch30]"'

# mysql
## -S: 折り返しなし
## -n: 行番号を表示しない
## -i: case insensitive
## -F: 一画面で全て表示した場合、lessを終了
## -X: 端末にtermcap初期化文字、非初期化文字を送らない
abbr --add mysql "mysql --pager 'less -S -n -i -F -X'"
#function mysql() { mysql $@ --pager'less -SniFX' }

# docker
abbr --add dck 'docker'
abbr --add dckc 'docker-compose'
abbr --add dck-ps 'docker ps'
abbr --add dck-psa 'docker ps -a'
# function dck-rma() { docker rm $@ $(docker ps -a -q) }

# CircleCI
abbr --add ci circleci

# truffle
abbr --add trf truffle

# gatsbyJS
abbr --add gats gatsby

# util
abbr --add relogin 'exec $SHELL -l'

# macos
abbr --add o 'open'
abbr --add chrome 'open -a "Google Chrome"'

# every
abbr --add ssh-dev-lithium 'ssh -i ~/.ssh/id_rsa -l siukaido ec2-13-230-27-147.ap-northeast-1.compute.amazonaws.com -p 50022'
abbr --add ssh-lithium 'ssh -i ~/.ssh/id_rsa -l siukaido lithium.mamadays.tv -p 50022'

# k8s
abbr --add k 'kubectl'

# laravel
abbr --add lrvl 'laravel'
abbr --add sail 'bash vendor/bin/sail'

