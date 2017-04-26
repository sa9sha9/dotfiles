#!/usr/bin/env bash
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

CURRENT_DIR=$(pwd)

## public_htmlの作成
if [[ ! -d ${HOME}/public_html ]]; then
    mkdir -p ${HOME}/public_html
fi

if [[ ! -d ${HOME}/git/docker ]]; then
    mkdir -p ${HOME}/git/docker
fi

# Install docker
if ! exists docker ; then
    echo $(tput setaf 6)"ERROR: 'docker' does not exists."$(tput sgr0)
    exit 1
fi

DOCKER_DIR=${HOME}/git/docker
cd ${DOCKER_DIR}

# Fetch DAMP
git clone https://github.com/yousan/damp.git
DAMP_DIR=${HOME}/git/docker/damp
cd ${DAMP_DIR}

# start DAMP
docker-compose up -d

cd ${CURRENT_DIR}
