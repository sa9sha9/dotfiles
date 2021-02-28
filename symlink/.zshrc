source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# zsh custome
if [ -d ${HOME}/.zsh ]; then
    for f in ${HOME}/.zsh/**/*
    do
      source $f
    done
fi