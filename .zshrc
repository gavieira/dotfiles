#TMUX plugin options
#export ZSH_TMUX_AUTOSTART=true

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
 DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
plugins=(git
	 tmux
	 autojump
	 dircycle
	 emacs
	 pass
	 rsync
	 sudo
	 zsh-autosuggestions
	 zsh-syntax-highlighting
	)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim' #USED TO BE 'mvim'
 fi

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
alias cp="rsync -rltzzuv --progress"
alias v="vim"
alias top="htop"
alias s="sudo"
alias l="ls -ltrah"
alias m="mpv"
alias du="du -h --max-depth=1 ."
alias r="ranger"
alias rr="ranger"
alias n="nnn"
#alias n="nnn -e" #The '-e' flag opens text in $VISUAL/$EDITOR/vi
#alias nnn="nnn -e" #The '-e' flag opens text in $VISUAL/$EDITOR/vi
alias z="zathura"
alias o="xdg-open"
alias tka="tmux kill-server" #Kills all tmux sessions


#Aliases for wps office
alias wpspread="et"
alias wpspres="wpp"


# Activating vim mode
 set -o vi
 bindkey vv vi-cmd-mode # used vv to avoid conflict with vim keys in tab complete menu
 bindkey jk vi-cmd-mode

# Adding keys for dircycle:
# Ctrl+Shift+arrows
 bindkey "\e[1;6D" insert-cycledleft
 bindkey "\e[1;6C" insert-cycledright
# Ctrl+Shift+h/l
 bindkey "^H" insert-cycledleft
 bindkey "^L" insert-cycledright
# Shift+arrows (need to remove tmux bindings if activated)
# bindkey "\e[1;2D" insert-cycledleft
# bindkey "\e[1;2C" insert-cycledright
# Alt+arrows (need to remove tmux bindings if activated)
# bindkey "\e[1;3D" insert-cycledleft
# bindkey "\e[1;3C" insert-cycledright

# Changing some bindings for autosuggestion:
#  bindkey '^N' autosuggest-fetch
#  bindkey '^\n' autosuggest-execute #Not working properly
 bindkey '^ ' autosuggest-accept

# Use vim keys in tab complete menu:
 bindkey -M menuselect 'h' vi-backward-char
 bindkey -M menuselect 'k' vi-up-line-or-history
 bindkey -M menuselect 'l' vi-forward-char
 bindkey -M menuselect 'j' vi-down-line-or-history

# History options - More on that on https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh 
SAVEHIST=100000 
#setopt BANG_HIST                 # Treat the '!' character specially during expansion.
#setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
#setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
#setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
#setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
#setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
#setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
#setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
#setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
#setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
#setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
#setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Command line fuzzy finder - https://github.com/junegunn/fzf
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gabriel/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gabriel/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gabriel/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gabriel/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gabriel/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gabriel/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gabriel/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gabriel/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Change locale (needed for some applications such as mira, but will break some powerlevel10k configurations)
#export LC_ALL=C

#Adding directories to PATH variable:
export PATH="$HOME/.local/bin:$PATH"

#Setting environmental variables
export BLASTDB="$HOME/blastdb"

#Setting termite as default TERM
export TERM=termite

#Setting NNN variables
export NNN_PLUG='g:fzcd;p:mpv;s:subliminal;f:ffsubsync;j:autojump;t:nmount;v:imgview'
export NNN_SSHFS='sshfs -o reconnect,idmap=user,cache_timeout=3600'
export NNN_BMS="b:${XDG_CONFIG_HOME:-$HOME/.config}/nnn/bookmarks;m:${XDG_CONFIG_HOME:-$HOME/.config}/nnn/mounts;p:${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins;s:${XDG_CONFIG_HOME:-$HOME/.config}/nnn/sessions"

#Setting default permissions for new files using umask (could be permanently changed in /etc/profile)"
#umask 002
#
#
#Auto enter i3 on startup
#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#	  exec startx
#fi
