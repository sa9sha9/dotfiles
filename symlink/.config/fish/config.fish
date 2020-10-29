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
## goenv
set -x GOENV_ROOT $HOME/.goenv
set -U fish_user_paths $GOENV_ROOT/bin

# postgres
set -x PGDATA /usr/local/var/postgres

# # pynev
# if type pyenv > /dev/null 2>&1; then
#    eval $(pyenv init -)
# fi

# nodenv
eval (nodenv init - | source)

# goenv
eval (goenv init - | source)
set -U fish_user_paths $GOROOT/bin
set -U fish_user_paths $GOPATH/bin

# dotenv
eval (direnv hook fish)


# abbr
# abbr --add l 'ls -lahGFA's
source ~/.config/fish/config_abbr.fish