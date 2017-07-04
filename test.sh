
bash test_child.sh
echo $#
echo 'parent back'
exit 1;

func() {
  echo "これが戻り値です。"
}
rtn=`func`

echo "戻り値=${rtn}"


exit 1
# functions
echo <<- 'EOF'
      $(tput setaf 4)
       ERROR: Failed writing into /etc/shells.
       Please change your shell from 'System Preference/User&Groups/AdvancedOptions(RightClick on your User Icon)
       $(tput sgr0)
EOF

BREW_ZSH_LOCATION=$(which zsh)
echo ${BREW_ZSH_LOCATION}
if [ ${BREW_ZSH_LOCATION} != "/usr/local/bin/zsh" ]; then
    echo $(tput setaf 4)"ERROR: brew-zsh does not installed!!"$(tput sgr0)
    exit 1
fi

exists() {
    command -v "$1" > /dev/null 2>&1
}
ask() {
  printf "$* [y/N] "
  local answer
  read answer

  #todo: Yesをデフォルトにしたいな
  case $answer in
    "yes" )  return 0 ;;
    "y"   )  return 0 ;;
    * )     return 1 ;;
  esac
}

if ask "hoge"; then
    echo "1"
else
    echo "0"
fi
