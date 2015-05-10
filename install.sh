#!/bin/bash

echo 'Downloading script.sh ...'
#curl -o /tmp/script.sh https://raw.githubusercontent.com/shaps80/bash/master/script.sh

echo 'Backing up to ~/script_backup ...'

bashrc=".bashrc"
bashprofile=".bash_profile"
backup="~/script_backup"

if [ -z "$backup" ]; then
  mkdir "$backup"
fi

if  [ ! -z "~/$bashrc" ]; then
  echo "copying " "~/$bashrc" "to" "$backup/$bashrc"
#  cp "~/$bashrc" "$backup/$bashrc"
fi

if  [ ! -z "~/$bashprofile" ]; then
  echo "Copying " "~/$bashprofile" "to" "$backup/$bashprofile"
#  cp "~/$bashprofile" $backup/$bashprofile
fi

echo "Would you like to save this as (1) ~/.bashrc or (2) ~/.bash_profile -- defaults to 1"
read -n result

if [ $result == 1]; then
  
fi

echo 'Done - restart or logout to load this script'