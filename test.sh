# functions
exists() {
    command -v "$1" > /dev/null 2>&1
}
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

if exists "docker"; then
    echo "1"
else
    echo "0"
fi
