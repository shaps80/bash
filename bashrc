#!/usr/bin/env bash
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

export GEM_HOME=~/.gems
export PATH=$PATH:~/.gems/bin
