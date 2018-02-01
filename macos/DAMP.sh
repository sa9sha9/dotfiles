#!/usr/bin/env bash
# Install docker
if ! exists docker ; then
    echo $(tput setaf 6)"ERROR: 'docker' does not exists."$(tput sgr0)
    brew install docker
fi

# Install docker app
if [[ ! -x /Applications/Docker.app ]]; then
    brew cask install docker
fi

open -a /Applications/Docker.app

## public_htmlの作成
if [[ ! -d ${HOME}/public_html ]]; then
    mkdir -p ${HOME}/public_html
    echo $(tput setaf 2)"SUCCESS: ~/public_html has created."$(tput sgr0)
fi

# docker dirを作成
if [[ ! -d ${HOME}/git/docker ]]; then
    mkdir -p ${HOME}/git/docker
    echo $(tput setaf 2)"SUCCESS: ~/git/docker has created."$(tput sgr0)
fi


DOCKER_DIR=${HOME}/git/docker
pushd ${DOCKER_DIR}

# Fetch DAMP
DAMP_DIR=${DOCKER_DIR}/damp
if [[ ! -d ${DAMP_DIR} ]]; then
    git clone https://github.com/yousan/damp.git
fi

pushd ${DAMP_DIR}

# start DAMP
if ! exists docker-compose ; then
    echo $(tput setaf 6)"ERROR: 'docker-compose' does not exists."$(tput sgr0)
    brew install docker-compose
fi

docker-compose up -d

popd
popd # now on ~/git/dotfiles/macos
