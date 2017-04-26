ask() {
  printf "$* [Y/n] "
  local answer
  read answer

  #todo: Yesをデフォルトにしたいな
  case $answer in
    "no" )  return 1 ;;
    "n"  )  return 1 ;;
    * )     return 0 ;;
  esac
}

if ask "hoge"; then
    echo "1"
else
    echo "0"
fi
