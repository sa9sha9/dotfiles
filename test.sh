echo $(tput setaf 2)"START: chsh -s /usr/local/bin/zsh"$(tput sgr0)

if [ ! -f "/usr/local/bin/zsh" ]; then
    echo $(tput setaf 4)"brew-zsh does not installed!!"$(tput sgr0)
    exit 1
fi
