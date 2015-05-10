#!/bin/bash

echo 'Downloading script.sh ...'
curl -o /tmp/script.sh https://raw.githubusercontent.com/shaps80/bash/master/script.sh

echo 'Backing up to ~/script_backup ...'

bashrc=".bashrc"
bashprofile=".bash_profile"
backup="~/script_backup/"

if  [ ! -z "~/$bashrc" ]; then
  echo "copying " "~/$bashrc" "to" "$backup/$bashrc"
#  cp "~/$bashrc" "$backup/$bashrc"
fi

if  [ ! -z "~/$bashprofile" ]; then
  echo "Copying " "~/$bashprofile" "to" "$backup/$bashprofile"
#  cp "~/$bashprofile" $backup/$bashprofile
fi

echo 'Done - restart or logout to load this script'