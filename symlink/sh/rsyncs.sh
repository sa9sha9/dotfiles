#!/bin/bash

# music
echo "[music sync..]"
rsync --progress -auzh \
$HOME/Downloads/music/ \
/Volumes/HD-LCU3/other/music

# n_movie
echo "[movie sync..]"
rsync --progress -auzh \
$HOME/Downloads/movie/ \
/Volumes/HD-LCU3/other/movie/other

# remote(ssh)
#rsync -e "ssh hoge.fuga" \
#SOURCE
#DEST

# test
#rsync --progress --stats -auzh \
#/Volumes/migite/sync/ \
#/Volumes/HD-LCU3/other/tmp/

# virtual test (-n command)
#rsync --delete -n -auzv \
#/Volumes/migite/sync/ \
#/Volumes/HD-LCU3/other/tmp
