#!/usr/bin/env bash

########################################################################################################################
## ANSIBLE
########################################################################################################################

alias ans=ansible
alias ansp='ansible-playbook --diff'
alias ansg='ansible-galaxy'
alias ansl='ansible-lint -x 701,401'
alias ansv='ansible-vault'


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
## BAT
########################################################################################################################

is_executable bat && {
  alias less='bat'
  alias cat='bat'
  alias more='bat'
}


########################################################################################################################
## BC
########################################################################################################################

alias bc='bc --mathlib'


########################################################################################################################
## COPY & PASTE
########################################################################################################################

if is_macos; then
  alias copy='pbcopy'
  alias paste='pbpaste'
elif is_executable xclip; then
  alias copy='xclip -selection clipboard'
  alias paste='xclip -selection clipboard -o'
fi


########################################################################################################################
## CORE UTILS
########################################################################################################################

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias cp='cp -v'
alias rm='rm -v'

# try to use the best ls we have available
if is_executable exa; then
  alias ls='exa --all --long --classify --group --time-style long-iso'
elif is_macos && is_executable gls; then
  alias ls='gls -alh --color=auto'
else
  alias ls='ls -alh --color=auto'
fi

# don't bother checking if they're executable, because Darwin doesn't have these anyway
if is_macos; then
  alias md5sum='gmd5sum'
  alias sha1sum='gsha1sum'
  alias sha256sum='gsha256sum'
  alias sha512sum='gsha512sum'
  alias realpath='grealpath'

  # if gcat is executable, assume we have coreutils installed from macports
  is_executable gcat && {
    alias du='gdu --human-readable --apparent-size'
    alias du1='du --max-depth=1'
  }

else
  alias du='du --apparent-size'
fi


########################################################################################################################
## CUSTOM FUNCTIONS (SEE 03-FUNCTIONS.SH)
########################################################################################################################

alias hashdir='dirhash'
alias howbig='dirsize'


########################################################################################################################
## DMESG
########################################################################################################################

! is_macos && alias dmesg='dmesg --color=auto --reltime --human --nopager --decode'


########################################################################################################################
## DOCKER
########################################################################################################################

is_executable docker         && alias d='docker'
is_executable docker-compose && alias dc='docker-compose'


########################################################################################################################
## GREP
########################################################################################################################

alias grep='grep --color=auto'


########################################################################################################################
## PS/PSTREE
########################################################################################################################

alias ps='ps -A -o pid=PID,ppid=PARENT,ruser=USER,nice=NICE,state=STATE,time=TIME,tt=TTY,args=CMD -ww'

if is_macos; then
  if is_executable pstree; then
    # -g n  -  Use graphics chars for tree.  n = 1: IBM-850, n = 2: VT100, n = 3: UTF8.
    # -w    -  Wide output, not truncated to terminal width.
    alias pstree='pstree -g 2 -w'
  fi
else
  alias pstree='ps --forest'
fi


########################################################################################################################
## SED
########################################################################################################################

if is_macos && is_executable gsed; then
  alias sed='gsed -E'
else
  alias sed='sed -E'
fi


########################################################################################################################
## SYSTEMD
########################################################################################################################

if ! is_macos; then
  alias sc='sudo systemctl'
  alias scu='systemctl --user'
  alias j='sudo journalctl'

   # no real reason to ever run systemd directly, so assume this is a d'oh moment and revert to sc
  alias systemd='sc'
fi


########################################################################################################################
## TERRAFORM
########################################################################################################################

alias tf='terraform'


########################################################################################################################
## TREE
########################################################################################################################

alias tree='dirtree'


########################################################################################################################
## VI(M)
########################################################################################################################

alias vi='vim'

