#!/usr/bin/env bash

source ~/.bashrc
source ~/.profile

alias open.='open .'
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -al'
alias ld='ls -ld -- *'
alias lh='ls -ld .[^.]*'
alias grep='grep --color=auto'

alias byword="open -a /Applications/Byword.app/"
alias mate_bash="mate ~/.bash_profile"
alias mate_tig="mate ~/.tigrc"
alias mate_git="mate ~/.gitconfig"

function post() {
  year=$(date +"%Y")
  month=$(date +"%B")
  post_dir="$year/$month"
  current_date=$(date +"%Y-%m-%d")
  
  path=$(octopress new post --template post --dir "$post_dir" "$1")
  
  if [[ $? != 0 ]]; then
    echo "A post with that title already exists!"
    return
  fi
  
  echo "Create new post $path..."
  byword $path
}

function page() {  
  octopress new page --dir "$1" "$2"
}

alias page="octopress new page"
alias publish="octopress publish"
alias unpublish="octopress unpublish"

alias gs="git st" # show status
alias gd="git del" # delete branch
alias go="git co" # switch branch
alias gb="git nb" # new branch
alias gc="git com" # commit
alias gn="git new" # show new commits since last pull
alias g+="git add"

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
alias psql="'/Applications/Postgres.app/Contents/Versions/9.3/bin'/psql -p5432"
alias irc="weechat"

export EDITOR="/usr/bin/emacs"
export TASKS_FILE="$HOME/.tasks"

# colors
black='\001\033[30m\002'
white='\001\033[37m\002'
red='\001\033[31m\002'
green='\001\033[32m\002'
yellow='\001\033[33m\002'
blue='\001\033[34m\002'
magenta='\001\033[35m\002'
cyan='\001\033[36m\002'

# formatting
underline='\001\033[4m\002'
bold='\001\033[1m\002'
blink='\001\033[5m\002'

# reset color and formatting
reset='\001\033[0m\002' 

print() {  
  for i in "${@:2}"; do
    printf "$i"
  done

  printf "${1}$reset";
}

printn () {
  print "$@"
  printf "\n"
}

no_internet() {
  printn "You don't appear to have an internet connection." $red
}

mark() {
  echo ""
  printf $magenta
  echo $(date)
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
  printf $reset
  echo ""
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
  print "$2" $blue
}

configure_greeting() {
  if [ $dashboard_hour -ge 0 -a $dashboard_hour -lt 12 ]
  then
    greet="Good Morning, $USER"
  else
    greet="Good Afternoon, $USER"
  fi
}

configure_network() {
  if [[ -z $dashboard_ip ]]; then
  	dashboard_network="$red""No Connection""$reset"
  else
    ping=$(ping -s1 -t1 -n -i0.1 -c1 8.8.8.8 2> /dev/null)
    if [[ -z $ping ]]; then
      dashboard_network="$dashboard_ip <$yellow""No Internet""$reset>"
    else
      dashboard_network="$dashboard_ip $reset"
    fi
  fi
}

show_todo() {
  todo -l > /dev/null 2>&1
  
  if [ $? -eq 0 ]; then
    echo ""
    echo "$(todo -l)"
  else
    echo ""
    echo ""
  fi
}

restore_pwd() {
  local search=' '
  local replace='%20'
  local pwd_url="file://$HOSTNAME${PWD//$search/$replace}";
  printf '\e]7;%s\a' "$pwd_url"
}

set_title() {  
  current_path=${PWD##*/}
  printf "\033]2;$current_path\007"
}

# [local..remote -> status] pwd #
set_prompt() {	  
  set_title
  restore_pwd # This MUST be called in order to restore the PWD after a relaunch!
  
  current_path="${PWD##*/}"
  local_branch="<no branch>"
  remote_branch="<no remote>"
  git_status=""
  
	git rev-parse > /dev/null 2>&1

	if [[ $? -ne 0 ]]; then
  	# we're not inside a repo 
    PS1="$current_path # "
  else
    branch="$(git branch | grep \*)"
  
    if [[ ! -z $branch ]]; then
      # we have a local branch
      branch="${branch//\* /}"
      local_branch="$branch"
    
      git diff-index --quiet HEAD -- > /dev/null 2>&1
    
      if [ $? -ne 0 ]; then
        # the repo has changes
        local_branch="$red$local_branch"
      else
        untracked=$(git ls-files --others --exclude-standard) > /dev/null 2>&1
      
        if [[ ! -z $untracked ]]; then
          # the repo has untracked files only
          local_branch="$yellow$local_branch"
        else
          local_branch="$green$local_branch"
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
        git_status="$reset ->$green up-to-date$reset"
      elif [ $LOCAL = $BASE ]; then
        git_status="$reset ->$yellow behind$reset"
      elif [ $REMOTE = $BASE ]; then
        git_status="$reset ->$yellow ahead$reset"
      else
        git_status="$reset ->$yellow diverged$reset"
      fi
    fi
  
    PS1="[$local_branch$reset..$remote_branch$git_status] $current_path # "
  fi
}

present_dashboard() {
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
  dashboard_ip=$(ifconfig en0 | awk '/inet / {print $2}' | sed 's/^[addr:]*//g')

  configure_greeting
  configure_network

  printn "$greet"

  add_dashboard "Network" "$dashboard_network"
  add_dashboard "Uptime" "$dashboard_uptime"
  add_dashboard "Current Path" "$dashboard_path"

  show_todo
}

clear
present_dashboard

export PROMPT_COMMAND='set_prompt'
export PS2='# '
export PS3='# '
export PS4='# '

