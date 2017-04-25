git-add-all-git-commit-git-push-all.zsh
#!/usr/bin/env zsh

# git add --all; git commit -m 'first commit'; git push --allgit add --all; git commit -m 'first commit'; git push --all をしてくれるコマンド

# Thanks @link http://qiita.com/mollifier/items/eba71bc33bb7e3b76233
# Thanks @link http://qiita.com/petitviolet/items/b1e8b5139169dd530919
# Thanks @link http://qiita.com/mollifier/items/6fdeff2750fe80f830c8

# Usage: gall [-m|--message message]
function gall() {
  local -A opthash
  local MESSAGE
  zparseopts -D -A opthash -- -help h -message: m:
  if [[ -n "${opthash[(i)--help]}" ]]; then
    echo 'Usage: gall [-m|--message message]'
    return 0
  fi
  if [[ -n "${opthash[(i)-h]}" ]]; then
    echo 'Usage: gall [-m|--message message]'
    return 0
  fi

  if [[ -n "${opthash[(i)--message]}" ]]; then
     MESSAGE=${opthash[--message]}
  fi
  if [[ -n "${opthash[(i)-m]}" ]]; then
     MESSAGE=${opthash[-m]}
  fi
  if [[ $MESSAGE ]] then
     CMD="git add --all; git commit -m '${MESSAGE}'; git push"
  else
     CMD="git add --all; git commit -m 'Automatically commit'; git push"
  fi
  eval ${CMD}
}

_gacmd() {
  _arguments \
  -m'[commit message]' \
  --message'[commit message]'
}

compdef _gacmd gall
