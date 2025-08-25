# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/eloughlin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/eloughlin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/eloughlin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/eloughlin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
export PATH="/usr/local/anaconda3/bin:$PATH"
# <<< conda initialize <<<

export PATH="/usr/local/bin:$PATH"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
   # Determine the branch name to pull from (main or master)
    upstream_branch=""
    if git rev-parse --verify main &> /dev/null; then
      upstream_branch="main"
    elif git rev-parse --verify master &> /dev/null; then
      upstream_branch="master"
    fi

    echo "Upstream branch detected: ${upstream_branch}"

    my_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD) #Name of current branch you're on
    my_branch_old="${my_branch}_old" # Name of temporary branch
    git branch -m ${my_branch_old} # Re-name current branch to temp name
    git checkout ${upstream_branch}
    git pull
    git checkout -b ${my_branch} # Checkout new branch with existing name, up-to-date with master
    git merge --squash ${my_branch_old} # Merge changes from your temp branch into this updated branch
    git add .
    git commit # Fix up your commit message

    echo "Deleting branch ${my_branch_old}"
    git branch -D ${my_branch_old} # Delete the old temporary branch

    # If there are uncommitted changes, something went wrong. Do NOT push!
    echo "Check if everything is good. If so, run the following command:"
    echo "git push origin +${my_branch}" # Re-write history on your existing branch
}

# Gives an HTTPS URL for the Github branch 
function giturl() {
  local branch=$(git symbolic-ref --short HEAD)
  local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
  local remote=$(git config --get branch.$branch.remote)
  local url=$(git config --get remote.$remote.url | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git//g')

  echo "$url/tree/$branch"
}

# Docker Helpers
# alias docker_killall="docker container kill $(docker ps -q)"

# Find And Replace Alias
far() {
    pattern=$1
    find_str=$2
    replace_str=$3
    find . -type f -name "$pattern" -print0 | while IFS= read -r -d '' file; do
        if grep -q "$find_str" "$file"; then
            echo "Modifying file: $file"
            sed -i '' -e "s|$find_str|$replace_str|g" "$file"
        fi
    done
}

# Same as far, but only for git tracked files. Much faster.
farg() {
    ext="$1"         # e.g., "*.py"
    find_str="$2"
    replace_str="$3"

    git grep -lz "$find_str" -- "$ext" | while IFS= read -r -d '' file; do
        echo "Modifying file: $file"
        sed -i '' -e "s|$find_str|$replace_str|g" "$file"
    done
}

# Python
alias python=python3

# Git helper command that checks out particular files from main
checkout_main() {
    if [ -z "$1" ]; then
        echo "Usage: checkout_main <filename>"
    else
        git ls-files | grep "$1" | xargs git checkout main --
    fi
}

gitq() {
	git pull
	git add .
	NOW=$( date '+%F_%H:%M:%S' );
	git commit -m "${NOW}"
	git push
}
alias gs="git status"

# Git Stuff
alias gs="git status"
alias gg="git grep"

pull_all() {
  local ws_dir="$HOME/ws"
  local original_dir="$(pwd)"
  local stay_on_original_branch=false
  local stringParam=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --stay)
        stay_on_original_branch=true
        shift
        ;;
      -s)
        shift
        stringParam="$1"
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
    if [[ "$folder" != *"$stringParam"* ]]; then
      continue
    fi

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
gcom() {
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
}

git_dangerously_delete_history() {
  current_repo=$(git remote show origin -n | grep "Fetch URL" | sed 's/.*://;s/.git$//')

    upstream_branch=""
    if git rev-parse --verify main &> /dev/null; then
      upstream_branch="main"
    elif git rev-parse --verify master &> /dev/null; then
      upstream_branch="master"
    fi

  if confirm_action "Do you want to proceed? This action will delete the entire remote history in the '$current_repo' repository. Are you sure you want to continue?"; then
    git checkout --orphan latest_branch

    git add -A

	  NOW=$( date '+%F_%H:%M:%S' );
	  git commit -am "Deleted all history prior to ${NOW}"

    git branch -D $upstream_branch

    git branch -m $upstream_branch

    git push -f origin $upstream_branch
  fi
}

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

## Function to display the warning message and get user confirmation
confirm_action() {
    warning_message=$1
    echo -n "$warning_message (Y/n): "
    read choice
    case "$choice" in
        [yY]) return 0 ;;
        [nN]) return 1 ;;
        *) echo "Invalid choice. Please enter Y or n." ; confirm_action "$warning_message" ;;
    esac
}

# export GH_TOKEN=$(pass show api/tokens/github)
export OPENAI_API_KEY=$(pass show api/tokens/openai)

# Git Stuff
alias gs="git status"
alias gg="git grep"
alias gc="git commit"
alias gp="git push"


# AWS Auto Completion
complete -C aws_completer aws

# This is for Neovim Environments (Particularly Jupyter Notebook Support)
source ~/.virtualenvs/neovim/bin/activate >/dev/null 2>&1


# Used for installing a new kernel in Jupyter Notebooks based on the current environment
function install_kernel() {
    # Check if a project_name argument is provided
    if [ -z "$1" ]; then
        # If not, prompt the user
        if confirm_action "No project_name provided. Would you like to use the current directory name as the kernel name?"; then
            project_name=$(basename "$(pwd)")
            echo "Using current directory name: $project_name"
        else
            read -p "Please enter a custom project name: " project_name
        fi
    else
        # Use the provided project_name
        project_name=$1
    fi

    # Run the python command to install the kernel
    python -m ipykernel install --user --name "$project_name"
    echo "Kernel installed with name: $project_name"
}

delete_kernel() {
    if [ -z "$1" ]; then
        echo "Usage: delete_kernel <kernel_name>"
        return 1
    fi

    local kernel_name="$1"
    local kernel_path=$(jupyter kernelspec list | grep " $kernel_name$" | awk '{print $2}')

    if [ -z "$kernel_path" ]; then
        echo "Kernel '$kernel_name' not found."
        return 1
    fi

    echo "Deleting kernel '$kernel_name' at $kernel_path..."
    rm -rf "$kernel_path"

    if [ $? -eq 0 ]; then
        echo "Kernel '$kernel_name' deleted successfully."
    else
        echo "Failed to delete kernel '$kernel_name'."
        return 1
    fi
}

# Alias for quick access
alias installkernel='install_kernel'
alias lg='lazygit'

PATH=$PATH:$HOME/evans_environment/tools
