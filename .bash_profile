#!/bin/bash

alias grep='grep --color=auto'
alias mate_bash="mate ~/.bash_profile"
alias mate_tig="mate ~/.tigrc"
alias mate_git="mate ~/.gitconfig"

alias gs="git st" # show status
alias gd="git del" # delete branch
alias go="git co" # switch branch
alias gb="git nb" # new branch
alias gc="git com" # commit
alias gn="git new" # show new commits since last pull

alias cd_dev="cd ~/Development"
alias cd_personal="cd ~/Development/personal"
alias cd_tab="cd ~/Development/TAB"
alias cd_dropbox="cd ~/Dropbox"
alias cd_desktop="cd ~/Desktop"
alias cd_documents="cd ~/Documents"
alias cd_downloads="cd ~/Downloads"
alias cd_wallpapers="cd ~/Pictures/Wallpapers"

alias jekyll-serve="open_site & bundle exec jekyll serve -w"
alias jekyll-update="git add . ; git commit -am 'new post'; git push"

black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
none='\e[0m' # reset color

export PROMPT_COMMAND='setTitle'
export PS2='# '
export PS3='# '
export PS4='# '
export EDITOR="/usr/bin/emacs"

# print with color
cprint() { printf "${2}${1}$none"; }
# print with color and newline
cprintn() { printf "${2}${1}$none\n"; }
# set color -- don't forget to call setcolor $none to reset
setcolor() { printf $1; }

no_internet() {
  cprintn "You don't appear to have an internet connection." $red
}

mark() {
  echo ""
  cprintn "$(date) ----------------------------------------" $magenta
}

open_site() {
  sleep 1
  open "http://0.0.0.0:4000"
}

open_workspace_or_project_with_app()
{	
	if [[ -z "$1" || "$#" -ne 2 ]]; then
    echo -e "Nothing found\n"
		return
	fi
 
	IDEFileName=${2##*/}
	filename=${1##*/}
	echo -e "\nOpening $filename with $IDEFileName\n"
	open "$1" -a "$2"
}
 
select_workspace_or_project()
{
	count=$#
	file=""
	
	if [[ $count -eq 1 ]]; then
		file=$1
	elif [[ $count > 1 ]]; then
		echo ""
		
		for (( i = 0; i < $count; i++ )); do
			index=`expr $i + 1`
			eval "filename=\${$index}"
			echo -e "\t" "[$index]" "$filename"
		done
		
		printf "\nSelect the file to open: "
		read -s -n 1 result
		
		if [[ ! -z $result ]]; then
			eval "file=\${$result}"
		fi
	fi	
}
 
open_workspace_or_project() 
{	
	shopt -s nullglob
	workspaces=(*.xcworkspace)
	count=${#workspaces[@]}
	
	if [[ count -ne 0 ]]; then
		select_workspace_or_project "${workspaces[@]}"
		open_workspace_or_project_with_app "$file" $1
	else
		shopt -s nullglob
		projects=(*.xcodeproj)
		count=${#projects[@]}
	
		select_workspace_or_project "${projects[@]}"
		open_workspace_or_project_with_app "$file" $1
	fi
}
 
opena() {
	IDEPath="/Applications/AppCode.app"
	open_workspace_or_project "$IDEPath"
}
 
openx () {
	IDEPath="/Applications/Xcode.app"	
	open_workspace_or_project "$IDEPath"
}

add_dashboard() {
  printf "\n%20s  %s" "$1"
  cprint "$2" $blue
}

setTitle() {	  
  local search=' '
  local replace='%20'
  local current_path="${PWD##*/}"
  local local_branch="$red<no branch>$none"
  local remote_branch="$red<no remote>$none"
  local status=""
  
	git rev-parse > /dev/null 2>&1

	if [[ $? -ne 0 ]]; then
  	# we're not inside a repo 
    PS1="$current_path # "
    return
  fi
  
  branch=$(git branch | grep \*)
  
  if [[ ! -z $branch ]]; then
    # we have a local branch
    branch="${branch//\* /}"
    local_branch=$branch
    
    git diff-index --quiet HEAD -- > /dev/null 2>&1
    
    if [ $? -ne 0 ]; then
      # the repo has changes
      local_branch="$red$local_branch$none"
    else
      untracked=$(git ls-files --others --exclude-standard) > /dev/null 2>&1
      
      if [[ ! -z $untracked ]]; then
        # the repo has untracked files only
        local_branch="$yellow$local_branch$none"
      else
        local_branch="$green$local_branch$none"
      fi
    fi
  fi
  
  git rev-parse --symbolic-full-name --abbrev-ref $branch@{u} > /dev/null 2>&1
  
  if [ $? -eq 0 ]; then
    # we have a remote branch
    remote_branch=$(git rev-parse --symbolic-full-name --abbrev-ref $branch@{u})
    
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    BASE=$(git merge-base @ @{u})
    
    if [ $LOCAL = $REMOTE ]; then
      status=" ->$green up-to-date$none"
    elif [ $LOCAL = $BASE ]; then
      status=" ->$red behind$none"
    elif [ $REMOTE = $BASE ]; then
      status=" ->$green ahead$none"
    else
      status=" ->$yellow diverged$none"
    fi
  fi
  
  PS1="[$local_branch..$remote_branch$status] $current_path # "
}

clear
cat <<EOF    

                         ''~\`\`
                        ( o o )
+------------------.oooO--(_)--Oooo.------------------+
|                                                     |
|                    .oooO                            |
|                    (   )   Oooo.                    |
+---------------------\ (----(   )--------------------+


EOF

dashboard_hour=$(date +"%H")
dashboard_uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
dashboard_path="${PWD//$HOME/~}"
dashboard_ip=$(ifconfig en0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
dashboard_gateway=$(netstat -rn | grep "default" | awk '{print $2}')

# if it is midnight to midafternoon will say G'morning
if [ $dashboard_hour -ge 0 -a $dashboard_hour -lt 12 ]
then
  greet="Good Morning, $USER"
# if it is midafternoon to evening ( before 6 pm) will say G'noonx
elif [ $dashboard_hour -ge 12 -a $hour -lt 18 ] 
then
  greet="Good Afternoon, $USER"
else # it is good evening till midnight
  greet="Its late $USER, should you really be up this late?"
fi

if [[ -z $dashboard_ip ]]; then
	dashboard_network="$red""No Connection""$none"
else 
  if [[ -z $dashboard_gateway ]]; then
    dashboard_network="$dashboard_ip <$red""No Gateway""$none>"
  else
    ping=$(ping -s1 -t1 -n -i0.1 -c1 -o $dashboard_gateway)
    if [[ -z $ping ]]; then
    dashboard_network="$dashboard_ip <$yellow""No Internet""$none>"
    else
      dashboard_network="$dashboard_ip $none<$dashboard_gateway>"
    fi
  fi
fi

echo $greet
add_dashboard "Network" "$dashboard_network"
add_dashboard "Uptime" "$dashboard_uptime"
add_dashboard "Current Path" "$dashboard_path"

printf "\n\n"
