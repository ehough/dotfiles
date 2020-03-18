#!/usr/bin/env bash

# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
# shell will prefer your own functions over the pre-installed tools
man() {

  # env doesn’t know about shell functions; it knows about is the pre-installed tool called man.
  env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")"    \
    LESS_TERMCAP_md="$(printf "\e[1;31m")"    \
    LESS_TERMCAP_me="$(printf "\e[0m")"       \
    LESS_TERMCAP_se="$(printf "\e[0m")"       \
    LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")"       \
    LESS_TERMCAP_us="$(printf "\e[1;32m")"    \
    man "$@"
}


########################################################################################################################
## MYIP - finds public IP
########################################################################################################################

myip() {

  local -r list=('https://myip.dnsomatic.com/' 'https://checkip.dyndns.com/' 'https://checkip.dyndns.org/')
  local result url

  for url in ${list[*]}; do

    if result=$(curl -s "${url}"); then
      echo "$result"
      break
    fi
  done
}


########################################################################################################################
## HASHDIR - hashes the contents of a directory with md5sum
########################################################################################################################

hashdir() {

  if [[ ! -d "$1" ]]; then
    exit 1
  fi

  find "$1" -type f -exec md5sum {} + | cut -d ' ' -f 1 | sort | md5sum | cut -d ' ' -f 1
}


########################################################################################################################
## HOWBIG - what's the size of the contents of a directory?
########################################################################################################################

howbig() {

  du -h "$1" | tail -n 1 | cut -f 1
}


########################################################################################################################
## TREE
########################################################################################################################

tree() {

  command tree -aC -I ".git|node_modules|bower_components" --dirsfirst "$1" | less
}


########################################################################################################################
## PS
########################################################################################################################

ps() {

  if is_macos && is_executable pstree; then
    /opt/local/bin/pstree -g 3 -w
  else
    /bin/ps aux --forest "$@"
  fi
}


########################################################################################################################
## APT
########################################################################################################################

if is_executable apt; then
  aptsearch() {
    apt-cache search "$1" | sort | less
  }
fi
