# prepare util
DOTFILES_DIR=${HOME}/git/dotfiles
source ${DOTFILES_DIR}/util.sh

# Ask which framework install as shell-scheme
ask_framework() {
  printf "$* [o(h-my-zsh)/F(ish)] "
  local answer
  read answer

  case $answer in
    o*   )  return 0 ;;
    f*   )  return 1 ;;
    *    )  return 1 ;;
  esac
}

if ! exists brew; then
	echo $(tput setaf 4)"ERROR: You should install 'Homebrew' first."$(tput sgr0)
	exit 1
fi

if ask_framework "Which shell-scheme install?"; then
	bash ./shell/fish.sh
else
	bash ./shell/zsh.sh
fi