. /etc/ksh.kshrc

alias ..="cd .."
alias poweroff="doas /sbin/shutdown -p now"
alias repo="ssh rhipidon repo"
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias wtf="wtf -o"
alias exti="exit"
alias gpg="gpg2"

# Use the light theme for vim when launched from a terminal with LIGHTBG set.
[ ! -z "$LIGHTBG" ] && alias vim='vim "+set background=light" "+syntax off"' 

mkcd() { mkdir -p "$1" && cd "$1"; }
say() { echo "$@" | festival --tts; }

reset="\e[0m"
red="\e[1;31m"
blue="\e[1;34m"
green="\e[1;32m"

PS1="\[$green\]\u@\h\[$blue\](\w)\[$reset\]\$ "

printf "$blue$(/usr/games/fortune)$reset\n\n"
