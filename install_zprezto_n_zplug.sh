# Check existance of a command
has() {
  type "$1" > /dev/null 2>&1
}

if has "zsh"; then
    zsh
else
    echo "ERROR: You should install 'zsh' first!"
    exit 1;
fi

# install 'zprezto'
if type "git" > /dev/null 2>&1; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
    echo "ERROR: You should install 'git' first!"
# sh -c "$(curl -fsSL https://github.com/sorin-ionescu/prezto/blob/master/init.zsh)"
fi

# Create a new Zsh configuration
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Change a shell
chsh -s /bin/zsh


