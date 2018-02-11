# prepare util
DOTFILES_DIR=${HOME}/git/dotfiles
source ${DOTFILES_DIR}/util.sh

SYNC_DIR=${HOME}/Sync/GoogleDrive/Sync/macOS
LIBRARY_DIR=${HOME}/Library

if [[ ! -d ${SYNC_DIR} ]]; then
    echo "ERROR: ${SYNC_DIR} not exists."
    exit 1
fi

# home setting file
ln -snfv ${SYNC_DIR}/.config ${HOME}
ln -snfv ${SYNC_DIR}/.ssh ${HOME}

# iTerm2
ln -snfv ${SYNC_DIR}/iTerm2 ${LIBRARY_DIR}
ln -snfv ${SYNC_DIR}/iTerm2/sak.iterm2.config $HOME/Library/Application\ Support/iTerm2/DynamicProfiles

# Dash
ln -snfFv ${SYNC_DIR}/Dash ${LIBRARY_DIR}


# plist
for f in ${SYNC_DIR}/Library/Preferences/*; do
    # todo: ignore 'Icon?'
    #        [[ ${f} = "Icon" ]] && continue
    ln -snfFv ${f} ${LIBRARY_DIR}/Preferences
done
# 先頭 "." を処理できてないので別個で
ln -snfv ${SYNC_DIR}/Library/Preferences/.GlobalPreferences.plist ${LIBRARY_DIR}/Preferences


# printer
for f in ${SYNC_DIR}/Library/Printers/*; do
    ln -snfFv ${f} ${LIBRARY_DIR}/Printers
done


## optional
# Swap iTunes Backup folder to external drive
EX_MOBILE_SYNC_FOLDER=/Volumes/HD-LCU3/iOS/Backup
MOBILE_SYNC_FOLDER=${LIBRARY_DIR}/Application\ Support/MobileSync/Backup
if [[ ! -d ${EX_MOBILE_SYNC_FOLDER} ]]; then
    rm -rf ${MOBILE_SYNC_FOLDER}
    ln -snfv ${EX_MOBILE_SYNC_FOLDER} ${MOBILE_SYNC_FOLDER}
fi
