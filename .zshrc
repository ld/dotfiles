# Author: Lin Dong
# Date: Mon Feb 16 23:43:40 UTC 2015
# Dependences:
#     1. vim
#     1. tmux
#     3. fasd
#     4. zsh-syntax-highlighting
# ============================================

# Path to your oh-my-zsh installation.
export ZSH=/home/vagrant/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby rails rvm gem bundler fasd tmux zsh_reload zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Language environment support other non english languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# ==============================================================================
#                            User configuration
# ==============================================================================


# ========================= Vim ===============================
# Ubuntu
# sudo apt-get install vim
# sudo apt-get install vim-nox
# =============================================================

# Set up default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ========================= Node Only =========================
# curl -o node.tar.gz  http://nodejs.org/dist/v0.12.0/node-v0.12.0-linux-x64.tar.gz
# cd /usr/local
# sudo tar --strip-components 1 -zxf ~/node.tar.gz
# =============================================================
# node nvm
# source $(brew --prefix nvm)/nvm.sh
# source ~/.nvm/nvm.sh


# ========================= Ruby Only =========================

# rvm
# source ~/.rvm/scripts/rvm

# Add RVM to PATH for scripting
# PATH=$HOME/.rvm/bin:~/.pyenv/shims:$PATH #ADD pyenv to path


# ========================= Tmux Only =========================

# autocomplete for tmuxinator
# source ~/.bin/tmuxinator.zsh



# ========================= Python Only =======================

alias ipy='ipython'
alias ipython3='python3 -m IPython'

# execute virtualenv wrapper
# source /usr/local/bin/virtualenvwrapper.sh
# source /usr/bin/virtualenvwrapper.sh
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python

# set where virutal environments will live
# export WORKON_HOME=$HOME/.virtualenvs
# ensure all new environments are isolated from the site-packages directory
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# use the same directory for virtualenvs as virtualenvwrapper
# export PIP_VIRTUALENV_BASE=$WORKON_HOME
# makes pip detect an active virtualenv and install to it
# export PIP_RESPECT_VIRTUALENV=true

# if [[ -r ~/.dotfiles/virtualenvwrapper.sh  ]]; then
#   source ~/.dotfiles/virtualenvwrapper.sh
# else
#   echo "WARNING: Can't find virtualenvwrapper.sh"
# fi

# pyenv
# eval "$(pyenv init -)"
# export VIRTUALENVWRAPPER_PYTHON=/Users/ldong/.pyenv/shims/python
# Add auto complete to python
# export PYTHONPATH=$PYTHONPATH:$(which python)
# export PYTHONPATH=$PYTHONPATH:/Users/ldong/.pyenv/shims/python
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.4/site-packages
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages
# export PYTHONSTARTUP=~/.pythonrc



# ========================= Percol Only =======================
# Python 2.7
# sudo apt-get install python-setuptools
# sudo easy_install pip
# sudo pip install percol
# =============================================================
alias show_process="ps aux | percol | awk '{ print $2 }'"
alias kill_process="ps aux | percol | awk '{ print $2 }' | xargs kill"

# Interactive pgrep / pkill
function ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

function ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}
# zsh history search
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi


# ZLE key binding
# http://www.cs.elte.hu/zsh-manual/zsh_14.html
# http://zsh.sourceforge.net/Guide/zshguide04.html
bindkey -v
bindkey -M viins 'JJ' vi-cmd-mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '??' history-incremental-search-forward
bindkey -M vicmd 'H' percol_select_history

# Search for history key bindings
# ctrl+v UP
#bindkey "^[OA" up-line-or-history
# ctrl+v DOWN
#bindkey "^[OB" down-line-or-history
# bindkey "^[[A" up-line-or-history
# bindkey "^[[B" down-line-or-history
# bindkey "^R" history-incremental-search-backward

# Tetris
# autoload -U tetris
# zle -N tetris
# bindkey ^T tetris

# Seach file in vim CtrlP
ctrlp() {
  </dev/tty vim -c 'Unite file_rec/async'
}
zle -N ctrlp
bindkey "^p" ctrlp


# Edit command in vim ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# works without vim mode
#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search # Up
#bindkey "^[[B" down-line-or-beginning-search # Down


# You may already have those in your .zshrc somewhere
# autoload -U promptinit && promptinit
# autoload -U colors     && colors
# setopt prompt_subst
#
# Reset mode-marker and prompt whenever the keymap changes
function zle-line-init zle-keymap-select {
  vi_mode="$(vi_mode_indicator)"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Multiline-prompts don't quite work with reset-prompt; we work around this by
# printing the first line(s) via a precmd which is executed before the prompt
# is printed.  The following can be integrated into PROMPT for single-line
# prompts.

# local user_host='%B%n%b@%m'
# local current_dir='%~'
# precmd () print -rP "${user_host} ${current_dir}"

# ======================== Customized Scripts ==================================
# extract filename.zip
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# color man page
man() {
  /usr/bin/man $* | \
    col -b | \
    vim -R -c 'set ft=man nomod nolist' -
}

# json pretty print
alias json="python -mjson.tool"

# ======================== Customized Alias ===================
alias v='vim'

# Find out my ip
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias lanip="ifconfig | sed -n 's/.*inet addr:\([0-9.]\+\)\s.*/\1/p'"

# Kill process of retaining port
#sudo lsof -i :9000
#sudo kill -9 61342

# display the colors
alias colors='bash ~/.dotfiles/color.sh'
alias color256='python ~/.dotfiles/checkColor.py'

# remove vim cache files
alias rmswp='find . -name \*.swp -type f -delete'

# remove python pyc files
alias rmpyc='find . -name \*.pyc -type f -delete'

# echo "text" | rot13
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"

# Count files
alias countFiles='ls -1 | wc -l'

# download uses aria2
alias download='aria2c -s 10 '
alias downloadDirectory='wget -r -np '

# git push and pull
# git checkout --orphan gh-pages
alias gpushPages='git push origin gh-pages'
alias gpush='git push origin master'
alias gpull='git pull origin master'
alias gitname='git config --global user.name "Lin Dong"'
alias gitemail='git config --global user.email "ldong@gatech.edu"'
alias gclean='git reset --hard && git clean -dfx'

# Rails
alias railsUP='rails s -b 0.0.0.0'

# local http servers use python
alias httphere='python -m SimpleHTTPServer 8080'
alias httphereWithUpload='python ~/.dotfiles/SimpleHTTPServerWithUpload.py 8080'

alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias vi='vim'
alias javac="javac -J-Dfile.encoding=utf8"
alias grep="grep --color=auto"
alias -s html=vi  # open files in vim
alias -s rb=vi
alias -s py=vi
alias -s js=vi
alias -s c=vi
alias -s java=vi
alias -s txt=vi
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'



# =============================== Mac Only =====================================
# Set Solarized color
# export CLICOLOR=1
# export LSCOLORS=exfxcxdxbxegedabagacad

# Specify your defaults in this environment variable for brew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# kill docks
alias killdock='killall -KILL Dock'

# hide apps, i.e. sudo chflags hidden /Applications/Game\ Center.app
alias hideapp='sudo chflags hidden '

# pdf_join merged.pdf 1.pdf 2.pdf
function pdf_join {
  join_py="/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py"
  read "output_file?Name of output file > "
  "$join_py" -o $output_file $@ && open $output_file
}

# alias rm='rmtrash'

# whatis $(ls /bin | gshuf -n 1)

alias cleanDNS='sudo discoveryutil udnsflushcaches'

alias resetSparkInspector='rm ~/Library/Application Support/.spark_settings'

# ============================= Linux Only =====================================
# Set Solarized color
eval `dircolors ~/.dircolors`

# echo "Did you know that:"; whatis $(ls /bin | shuf -n 1)
# ============================ Theme ===========================================
# Set the colors to your liking
local vi_normal_marker="%{$fg[green]%}%BN%b%{$reset_color%}"
local vi_insert_marker="%{$fg[cyan]%}%BI%b%{$reset_color%}"
local vi_unknown_marker="%{$fg[red]%}%BU%b%{$reset_color%}"
local vi_mode="$vi_insert_marker"
vi_mode_indicator () {
  case ${KEYMAP} in
    (vicmd)      echo $vi_normal_marker ;;
    (main|viins) echo $vi_insert_marker ;;
    (*)          echo $vi_unknown_marker ;;
  esac
}

# ZSH theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}➦ %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}◒ "

local return_code="%(?..%{$fg[red]%}%? %{$reset_color%})"
local PROMPT='%F{green}➜ %2c%F{blue} [%f '
local RPROMPT='$(git_prompt_info) %F{blue}] %F{gray}${vi_mode} %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'

# ============================ Other Stuff =====================================
# ranger, vifm
# DEB for browser
# Htop, better than top
# z, fasd, better than autojump
# colors.sh
# spectacle, mac app
