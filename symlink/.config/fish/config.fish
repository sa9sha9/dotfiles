# PATH
## sh
set -U fish_user_paths $HOME/sh
## brew sbin
set -U fish_user_paths /usr/local/sbin
## fastlane
set -U fish_user_paths $HOME/.fastlane/bin
## npm bin
# set -U fish_user_paths (npm bin -g)
## go
set -U fish_user_paths $HOME/go/bin

# postgres
set -x PGDATA /usr/local/var/postgres

# anyenv
set -x PATH ~/.anyenv/bin $PATH
anyenv init - fish | source

# goenv
set -x GOENV_ROOT $HOME/.goenv
set -U fish_user_paths $GOENV_ROOT/bin
set -U fish_user_paths $GOROOT/bin
set -U fish_user_paths $GOPATH/bin
set -x GOPATH $HOME/go

# dotenv
eval (direnv hook fish)

# abbr
# abbr --add l 'ls -lahGFA's
source ~/.config/fish/config_abbr.fish