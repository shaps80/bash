bash_profile
============

My modified bash_profile. I was getting sick of the boring Terminal.app bash prompt and decided to spice things up a bit.

It currently supports:

* A welcome greeting specific to the time of day
* IP addresses from all interfaces on the computer
* SSID of the wifi network you're connected to (if applicable)
* Internet connection unavailable state (if applicable)
* Current working directory
* Uptime and number of users
* Overrides rm without affecting other scripts. Now when you run rm from bash it will move the file/folder to the Trash.
* Prompt now shows current branch (GIT) if you're inside a repo and also shows colored when the repo has uncommitted changes.
* Prompt also shows the local ip address of the machine you're connected to when ssh-ed to it.
* Makes textmate the default editor

The information is parsed and filtered to make things clean and I've attached a sample of what the terminal will look like. 

Although this script was written for OSX and the SSID detection is actually OSX specific, I have had this running on Ubuntu successfully. 

I'll run through various other linux distros when I get time and fix any issues, then I'll list the supported distros here. :)

Requirements
------------

* TextMate 2.0 - also requires installing shell support from Preferences.
* gls - ls replacement that has some nicer features. I may remove this requirement later.
* OSX - for SSID detection. I will find a better cross-platform way to do this later.
