# prepare util
DOTFILES_DIR=${HOME}/git/dotfiles
source ${DOTFILES_DIR}/util.sh

# Ask which framework install as shell-scheme
ask_framework() {
  printf "$* [O(h-my-zsh)/f(ish)] "
  local answer
  read answer

  case $answer in
    [oO]*   )  return 0 ;;
    [fF]*   )  return 1 ;;
    *    )  return 1 ;;
  esac
}

if ! exists brew; then
	echo $(tput setaf 4)"ERROR: You should install 'Homebrew' first."$(tput sgr0)
    /usr/bin/osascript -e 'display notification "Fail to set up of Shell-Scheme" with title "Failed"'
	exit 1
fi

/usr/bin/osascript -e 'display notification "Which shell-scheme do you install?" with title "Asking"'
if ask_framework "Which shell-scheme install?"; then
	bash ${MACOS_DIR}/shell/zsh.sh
else
	bash ${MACOS_DIR}/shell/fish.sh
fi