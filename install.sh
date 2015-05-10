#!/bin/bash

bashrc=".bashrc"
bashprofile=".bash_profile"
backup="$HOME/Backup"
script="/tmp/script.sh"

echo 'Downloading script.sh ...'
curl -o $script https://raw.githubusercontent.com/shaps80/bash/master/script.sh

if [ ! -d "$backup" ]; then
  mkdir "$backup"
fi

if  [ -f "$HOME/$bashrc" ]; then
  echo ""
  echo "Backing up $HOME/$bashrc to $backup/$bashrc"
  cp "$HOME/$bashrc" "$backup/$bashrc"
fi

if  [ -f "$HOME/$bashprofile" ]; then
  echo "Backing up $HOME/$bashprofile to $backup/$bashprofile"
  cp "$HOME/$bashprofile" $backup/$bashprofile
fi

echo ""
printf "\t 1: ~/.bash_profile (default)\n"
printf "\t 2: ~/.bashrc\n\n"
printf "Where would you like to install this script: "

read -n 1 result
echo ""

case ${answer:0:1} in
    2) 
    echo "Updating ~/$bashrc"
    cp $script $HOME/$bashrc
    ;;
    *) 
    echo "Updating ~/$bashprofile" 
    mv $script ~/$bashprofile
    
    ;;
esac

echo ""
echo 'Done - restart or logout to load this script'