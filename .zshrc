export HISTFILE=~/.zhistory
export HISTSIZE=50000
export SAVEHIST=50000
eval `dircolors -b`

export MANPATH="$HOME/.local/texlive/2019/doc/man:$MANPATH"
export INFOPATH="$HOME/.local/texlive/2019/doc/info:$INFOPATH"
export PATH="$HOME/go/bin:$HOME/.local/texlive/2019/bin/x86_64-linux:$PATH"

autoload -U compinit promptinit colors
compinit
promptinit
colors

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

setopt pushdminus pushdsilent pushdtohome pushd_ignore_dups
setopt cdablevars
setopt interactivecomments
setopt clobber
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt share_history
setopt SH_WORD_SPLIT
setopt nohup
setopt correct
setopt extendedglob
setopt long_list_jobs
setopt bash_auto_list
setopt hash_list_all
setopt no_beep
setopt transientrprompt

# PS1 and PS2
if [ -n "$SSH_CLIENT" ]; then
	PROMPT="%{$fg[blue]%}%n@%{$fg[magenta]%}%M: %{$fg[green]%}%~ %{$fg[red]%}%# %{$reset_color%}"
else
#    PROMPT="%{$fg[green]%}%~ %{$fg[red]%}%# %{$reset_color%}"
    PROMPT="%~ %# "
fi

# Command Correction Prompt
SPROMPT="Correct %{$fg[red]%}%R%{$reset_color%} to %{$fg[green]%}%r%{$reset_color%}? "

# SSH completion
local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts

# Exports
export EDITOR="nvim"
export BROWSER="firefox"
export PDFVIEWER="mupdf"

##################################################################
# Completion Related

zstyle ':completion:*' menu select
zstyle ":completion:*commands" rehash 1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# For kill/killall
zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:killall:*' menu yes select

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

typeset -g -A key

bindkey -e


# Normal aliases
alias ls='ls -v --color=auto'
alias ..='cd ..'
alias c='clear'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias halt='systemctl halt'
alias clean="echo -ne '\033c'"
alias rsync="rsync --progress"
alias sudo='sudo '
alias svim='sudoedit'
alias vim=nvim
## Functions
mkcd() { mkdir -p "$1" && cd "$1" }

school() { 
	local pth="${HOME}/documents/school/${1}"
	if [[ -d "$pth" ]]; then 
		cd "$pth"
	else
		${EDITOR} "$pth"
	fi
}
compdef '_files -W "${HOME}/documents/school"' school

COURSES=(enee101 enee150 enee205 enee244)
for course in $COURSES; do
	alias $course="school $course"
done

# Blur {{{
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|kitty$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi
# }}}

# added by Pew
source "$(pew shell_config)"
