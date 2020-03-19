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
alias du='du --apparent-size'

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

if is_macos; then
  alias md5sum='gmd5sum'
  alias sha1sum='gsha1sum'
fi;


########################################################################################################################
## BAT
########################################################################################################################

if is_executable bat; then
  alias less='bat'
  alias cat='bat'
  alias more='bat'
fi


########################################################################################################################
## MISC. APPS
########################################################################################################################

alias ans=ansible
alias ansp=ansible-playbook
alias bc='bc --mathlib'
alias dmesg='dmesg --color=auto --reltime --human --nopager --decode'
alias tf='terraform'
alias vi='vim'

########################################################################################################################
## PBCOPY/PBPASTE
########################################################################################################################

if ! is_macos && is_executable xclip; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi


########################################################################################################################
## APT
########################################################################################################################

if is_executable apt; then
  alias aptinstall='sudo apt-get install --no-install-recommends'
  alias aptshow='apt-cache show'
  alias aptpurge='sudo apt-get purge'
  alias aptupdate='sudo apt-get update'
  alias aptupgrade='aptupdate && sudo apt-get dist-upgrade'
fi
