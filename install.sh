#!/bin/bash

echo 'Downloading script.sh ...'
curl -o /tmp/script.sh https://raw.githubusercontent.com/shaps80/bash/master/script.sh

bashrc=".bashrc"
bashprofile=".bash_profile"
backup="~/script_backup"
script="script.sh"

if [ -z "$backup" ]; then
  mkdir "$backup"
fi

if  [ ! -z "~/$bashrc" ]; then
  echo ""
  echo "Backing up ~/$bashrc to $backup/$bashrc"
  cp "~/$bashrc" "$backup/$bashrc"
fi

if  [ ! -z "~/$bashprofile" ]; then
  echo "Backing up ~/$bashprofile to $backup/$bashprofile"
  cp "~/$bashprofile" $backup/$bashprofile
fi

echo ""
printf "\t 1: ~/.bash_profile (default)\n"
printf "\t 2: ~/.bashrc\n\n"
printf "Where would you like to install this script: "

read -n 1 result
echo ""

case ${answer:0:1} in
    2) 
    echo "Copying $script to ~/$bashrc"
    cp $script ~/$bashrc
    ;;
    *) 
    echo "Copying ~/$script to ~/$bashprofile" 
    cp $script ~/$bashprofile
    
    ;;
esac

rm $script

echo ""
echo 'Done - restart or logout to load this script'