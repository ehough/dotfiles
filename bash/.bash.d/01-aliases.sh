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

alias cp='/bin/cp -v'
alias rm='/bin/rm -v'

if [[ "$OSTYPE" = 'darwin'* && -x /opt/local/bin/gls ]]; then
  alias ls='/opt/local/bin/gls -alh --color=auto'
else
  alias ls='/bin/ls -alh --color=auto'
fi


########################################################################################################################
## GREP
########################################################################################################################

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


########################################################################################################################
## CRYPTO
########################################################################################################################

if [[ "$OSTYPE" = 'darwin'* ]]; then
  alias md5sum='/opt/local/bin/gmd5sum'
  alias sha1sum='/opt/local/bin/gsha1sum'
fi


########################################################################################################################
## VIM
########################################################################################################################

alias vi='/usr/bin/vim'


########################################################################################################################
## BAT
########################################################################################################################

alias less='bat'
alias cat='bat'
alias more='bat'


########################################################################################################################
## NETWORK
########################################################################################################################

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
