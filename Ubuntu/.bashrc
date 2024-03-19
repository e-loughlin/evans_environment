
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Comedy
alias dufo='sudo'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Go setup
export GOPATH=$HOME/ws/go
export GOBIN="${GOPATH}/bin"
export PATH="${GOBIN}:${PATH}"
export GOROOT=/usr/local/go
export PATH="${GOROOT}/bin:${PATH}"

#### Cool Tricks

# Line Diff: Print each line in file_1 which is not contained in file_2 (irrespective of order)
# Example usage: line_diff file1.txt file2.txt
line_diff() {
	comm -23 <(sort -u $1) <(sort -u $2)
}

# Git Re-write History (Use at your own Risk!)
# Must run WHILE IN the branch you wish to update.
git_update_branch() {
        my_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD) #Name of current branch you're on
        my_branch_old="${my_branch}_old" # Name of temporary branch
        git branch -m ${my_branch_old} # Re-name current branch to temp name

	# Determine the branch name to pull from (main or master)
	branch=""
	if git rev-parse --verify main &> /dev/null; then
	  branch="main"
	elif git rev-parse --verify master &> /dev/null; then
	  branch="master"
	fi
	git checkout $branch
        git pull
        git checkout -b ${my_branch} # Checkout new branch with existing name, up-to-date with master
        git merge --squash ${my_branch_old} # Merge changes from your temp branch into this updated branch
        git commit # Fix up your commit message
        git push origin "+${my_branch}" # Re-write history on your existing branch
        git branch -D ${my_branch_old} # Delete the old temporary branch
}

# Docker Helpers
# alias docker_killall="docker container kill $(docker ps -q)"

# Find And Replace Alias
far() {
	pattern=$1
	find_str=$2
	replace_str=$3
	find . -type f -name "$pattern" -print0 | xargs -0 sed -i 's|'"$find_str"'|'"$replace_str"'|g'
}

# Python
alias python=python3

# Git Quick Commit and Push
gitq() {
	git pull
	git add .
	NOW=$( date '+%F_%H:%M:%S' );
	git commit -m "${NOW}"
	git push
}

# Git Stuff
alias gs="git status"
alias gg="git grep"
alias gc="git commit"
alias gp="git push"

pull_all() {
  local ws_dir="$HOME/ws"
  local original_dir="$(pwd)"
  local stay_on_original_branch=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --stay)
        stay_on_original_branch=true
        shift
        ;;
      *)
        echo "Unknown option: $1"
        return 1
        ;;
    esac
  done

  if [ ! -d "$ws_dir" ]; then
    echo "Error: Workspace directory '$ws_dir' not found."
    return 1
  fi

  cd "$ws_dir" || return 1

  # Loop through each folder in ~/ws
  for folder in */; do
    cd "$folder" || continue

    # Determine the branch name to pull from (main or master)
    branch=""
    if git rev-parse --verify main &> /dev/null; then
      branch="main"
    elif git rev-parse --verify master &> /dev/null; then
      branch="master"
    fi

    if [ -n "$branch" ]; then
      echo "Pulling latest changes from $branch in $folder..."
      git pull origin "$branch"
      if [ "$stay_on_original_branch" = true ]; then
        git checkout -
      fi
    else
      echo "No 'main' or 'master' branch found in $folder. Skipping..."
    fi

    cd "$ws_dir" || return 1
  done

  cd "$original_dir" || return 1
  echo "All repositories have been pulled. Returned to the original directory."
}

grep_all() {
  if [ $# -ne 1 ]; then
    echo "Usage: grep_all <search_string>"
    return 1
  fi

  local search_string="$1"
  local ws_dir="$HOME/ws"
  local original_dir="$(pwd)"

  if [ ! -d "$ws_dir" ]; then
    echo "Error: Workspace directory '$ws_dir' not found."
    return 1
  fi

  cd "$ws_dir" || return 1

  # Loop through each folder in ~/ws
  for folder in */; do
    cd "$folder" || continue

    if git --no-pager grep "$search_string"; then
      echo "Found '$search_string' in $folder"
    else
      echo "'$search_string' not found in $folder"
    fi
    echo ""

    cd "$ws_dir" || return 1
  done

  cd "$original_dir" || return 1
  echo "Search completed. Returned to the original directory."
}

# Git Commit current branch name JIRA tag (i.e. CP-3454) with message
gco() {
  local branch_name="$(git symbolic-ref --short HEAD)"
  local branch_id="${branch_name:0:7}"
  local message="$1"
  
  echo "git commit -m \"$branch_id: $message\""
  git commit -m "$branch_id: $message"
}

# Delete git branches based on the argument provided
git_delete_branches() {
  if [[ "$1" == "-a" || "$1" == "--all" ]]; then
    git branch | xargs -n 1 git branch -d
  else
    git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
  fi

rename_files() {
  if [ $# -ne 2 ]; then
    echo "Usage: rename_files <search_string> <replace_string>"
    return
  fi

  search_string="$1"
  replace_string="$2"

  files_to_rename=()

  # Collect the list of files matching the search string
  while IFS= read -r -d $'\0' file; do
    files_to_rename+=("$file")
  done < <(find . -type f -name "*${search_string}*" -print0)

  # Process the list of files in a for loop
  for file in "${files_to_rename[@]}"; do
    new_file="${file//$search_string/$replace_string}"

    if [ "$file" != "$new_file" ]; then
      target_dir=$(dirname "$new_file")

      # Create the target directory if it doesn't exist
      mkdir -p "$target_dir"

      echo "Renaming: $file -> $new_file"
      if confirm_action "Do you want to proceed?"; then
        mv -i "$file" "$new_file"
        echo "Renamed."
      else
        echo "Not renamed."
      fi
    fi
  done
}


# Function to display the warning message and get user confirmation
confirm_action() {
    warning_message=$1
    while true; do
        read -p "$warning_message (Y/n): " choice
        case "$choice" in
            [yY]) return 0 ;;
            [nN]) return 1 ;;
            *) echo "Invalid choice. Please enter Y or n." ;;
        esac
    done
}

