if [[ ! -d ${HOME}/.ssh ]]; then
    if exists "ssh-keygen"; then
	ssh-keygen -t rsa -C $(whoami) #comment: USER-NAME                      
    else
        echo "ERROR: 'ssh-keygen' does not installed"
    fi
fi
# functions                                                                     
exists() {
    command -v "$1" > /dev/null 2>&1
}
