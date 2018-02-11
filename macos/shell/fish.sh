#!/usr/bin/env bash
if ! exists fish ; then
    brew install fish
fi

# Set fish as default shell
#/usr/bin/osascript -e 'display notification "Set default shell?" with title "Asking"'
#if ask "Set default shell with '/usr/local/bin/fish' ?"; then
#    echo $(tput setaf 2)"START: chsh -s /usr/local/bin/fish"$(tput sgr0)
#    BREW_FISH_LOCATION=$(which fish)
#    if [ ${BREW_FISH_LOCATION} != "/usr/local/bin/fish" ]; then
#        echo $(tput setaf 4)"ERROR: brew-fish does not installed!!"$(tput sgr0)
#        brew install fish
#    fi
#
#    /usr/bin/osascript -e 'display notification "Please input password" with title "Password Required"'
#    sudo sh -c "echo ${BREW_FISH_LOCATION} >> /etc/shells"
#    # If it writes into /etc/shells successfully
#    if [ $? -eq "0" ]; then
#        chsh -s ${BREW_FISH_LOCATION}
#        echo $(tput setaf 2)"Change shell complete. ✔"$(tput sgr0)
#	    /usr/bin/osascript -e 'display notification "Successfully set fish as default shell" with title "Success"'
#    else
#        echo $(tput setaf 6)"WARNING: Failed writing into /etc/shells"$(tput sgr0)
#        /usr/bin/osascript -e 'display notification "WARNING: Failed writing into /etc/shells" with title "Failed"'
#    fi
#fi
