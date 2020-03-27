#!/usr/bin/env bash

########################################################################################################################
## CD
########################################################################################################################

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'


########################################################################################################################
## FILE & DIRECTORY HANDLING
########################################################################################################################

alias cp='cp -v'
alias rm='rm -v'
alias tree='dirtree'
alias hashdir='dirhash'
alias howbig='dirsize'

if is_macos && is_executable gdu; then
  alias du='gdu --apparent-size'
elif ! is_macos; then
  alias du='du --apparent-size'
fi

# try to use the best ls we have available
if is_executable exa; then
  alias ls='exa --all --long --classify --group --time-style long-iso'
elif is_macos && is_executable gls; then
  alias ls='gls -alh --color=auto'
else
  alias ls='ls -alh --color=auto'
fi


########################################################################################################################
## GREP
########################################################################################################################

alias grep='grep --color=auto'


########################################################################################################################
## CRYPTO
########################################################################################################################

# don't bother checking if they're executable, because Darwin doesn't have these anyway
is_macos && {
  alias md5sum='gmd5sum'
  alias sha1sum='gsha1sum'
  alias sha256sum='gsha256sum'
  alias sha512sum='gsha512sum'
}


########################################################################################################################
## BAT
########################################################################################################################

is_executable bat && {
  alias less='bat'
  alias cat='bat'
  alias more='bat'
}


########################################################################################################################
## MISC. APPS
########################################################################################################################

alias ans=ansible
alias ansp=ansible-playbook
alias bc='bc --mathlib'
alias tf='terraform'
alias vi='vim'

! is_macos && alias dmesg='dmesg --color=auto --reltime --human --nopager --decode'


########################################################################################################################
## PBCOPY/PBPASTE
########################################################################################################################

if is_macos; then
  alias copy='pbcopy'
  alias paste='pbpaste'
elif is_executable xclip; then
  alias copy='xclip -selection clipboard'
  alias paste='xclip -selection clipboard -o'
fi


########################################################################################################################
## APT
########################################################################################################################

is_executable apt-get && {
  alias apt-install='sudo apt-get install --no-install-recommends'
  alias apt-show='apt-cache show'
  alias apt-purge='sudo apt-get purge'
  alias apt-update='sudo apt-get update'
  alias apt-upgrade='apt-update && sudo apt-get dist-upgrade'
}


########################################################################################################################
## PS/PSTREE
########################################################################################################################

alias ps='ps -ww  -A -o pid=PID,ruser=USER,nice=NICE,state=STATE,time=TIME,tt=TTY,args=CMD'

if ! is_macos; then
  alias pstree='ps --forest'
elif is_executable pstree; then
  # -g n  -  Use graphics chars for tree.  n = 1: IBM-850, n = 2: VT100, n = 3: UTF8.
  # -w    -  Wide output, not truncated to terminal width.
  alias ps='pstree -g 2 -w'
fi
