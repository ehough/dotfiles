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

myip() {

  dig +short myip.opendns.com @resolver1.opendns.com
}

hashdir() {

  if [[ ! -d "$1" ]]; then
    exit 1
  fi

  if [[ "$OSTYPE" = 'darwin'* && -x /opt/local/bin/gmd5sum ]]; then
    find "$1" -type f -exec /opt/local/bin/gmd5sum  {} + | cut -d ' ' -f 1 | sort | /opt/local/bin/gmd5sum | cut -d ' ' -f 1
  else
    find "$1" -type f -exec md5sum {} + | cut -d ' ' -f 1 | sort | md5sum | cut -d ' ' -f 1
  fi
}

tree() {

  command tree -aC -I ".git|node_modules|bower_components" --dirsfirst "$1" | less
}

########################################################################################################################
## PS
########################################################################################################################

ps() {

  if [[ "$OSTYPE" = 'darwin'* && -x /opt/local/bin/pstree ]]; then
    /opt/local/bin/pstree -g 3 -w
  else
    /bin/ps aux --forest "$@"
  fi
}
