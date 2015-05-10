#!/bin/bash

bashprofile=".bash_profile"
backup="$HOME/Backup"
script="/tmp/script.sh"

echo 'Downloading script.sh ...'
echo ""
curl -o $script https://raw.githubusercontent.com/shaps80/bash/master/script.sh

if [ ! -d "$backup" ]; then
  mkdir "$backup"
fi

echo ""

if  [ -f "$HOME/$bashprofile" ]; then
  echo "Backing up $HOME/$bashprofile to $backup/$bashprofile"
  cp "$HOME/$bashprofile" $backup/$bashprofile
fi

echo "Updating ~/$bashprofile" 
mv $script ~/$bashprofile

echo ""
echo 'Done - restart or logout to load this script'