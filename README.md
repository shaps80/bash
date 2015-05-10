BASH Profile
============

<img src="https://raw.githubusercontent.com/shaps80/bash/master/git-messages.jpg" name="Bash Login Script"/>

## Updates

More full-featured GIT support. Xcode support and more...
To install, copy the script to __'~/._bash_profile'__ or __'~/.bashrc'__

## Summary

As many of us developers know, working from Terminal on a Mac leaves something to be desired. 
I certainly find it faster to get things done, but only when I have the right information and tools at my fingertips.

So I set out to create a simple .bash_profile that would have pretty GIT output on the prompt, as well as a nice welcome message with relevant information. I also needed Xcode and GIT support baked in. 

For you AppCode users, there's some love for you too ;)

The most important upgrade to this version is that I've cleaned up the entire script to make it really easy to add custom 'dashboard' data, and to keep your aliases, etc... clean and out of the way at the top of the file.

## Dashboard

* A time-specific greeting
* IP address and gateway
* Connection state, IP, not connected, no internet, etc...
* Current working directory
* Current system uptime

## GIT Support

The prompt now shows various states to indicate the current status of your git repositories:

* If you're not inside a git repo, there's a nice fallback 'path-only' prompt
* If you are inside a repo with no branches
* If you have a local branch with no remote
* If you have changes on your local branch
* If you are ahead, behind, diverged or up-to-date on your local branch -- compare to remote
* and more... 

## Development

* openx will search first for an Xcode workspace, falling back to a project if none found
  - In the event you have multiple workspaces or projects, you will be prompted for a selection
* opena performs the same as above, but with AppCode as your editor choice

Requirements
------------

This script has **zero** dependencies! Enjoy ;)
