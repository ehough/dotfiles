#!/usr/bin/env bash

########################################################################################################################
## apt-search - searches apt, sorts it, and pipes it to less
########################################################################################################################

is_executable apt-cache && {
  apt-search() {
    apt-cache search "$1" | sort | less
  }
}


########################################################################################################################
## dirhash - hashes the contents of a directory with md5
########################################################################################################################

dirhash() {

  if [[ ! -d "$1" ]]; then
    exit 1
  fi

  local file_path

  # don't use -exec here so that we can rely on md5sum being aliased
  # https://stackoverflow.com/a/9612232
  find "$1" -type f -print0 | while IFS= read -r -d '' file_path; do
    md5sum "$file_path"
  done | cut -d ' ' -f 1 | sort | md5sum | cut -d ' ' -f 1
}


########################################################################################################################
## dirsize - what's the size of the contents of a directory?
########################################################################################################################

dirsize() {

  du -h --summarize "$1" | cut -f 1
}


########################################################################################################################
## dirtree - opinionated tree listing piped to less
########################################################################################################################

dirtree() {

  local -r path="${1:-.}"

  command tree -aC -I ".git|node_modules|bower_components|.idea" --dirsfirst "$path" | less
}


########################################################################################################################
## docker
########################################################################################################################

is_executable docker && {

  docker() {

    if [[ "$1" == 'ps' ]]; then
      command docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Image}}\t{{.Networks}}\t{{.Command}}'
    else
      command docker "$@"
    fi
  }
}


########################################################################################################################
## man - colorize output
########################################################################################################################

man() {

  env                                         \
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
## myip - finds public IP
########################################################################################################################

myip() {

  local -r list=('https://myip.dnsomatic.com/' 'https://checkip.dyndns.com/' 'https://checkip.dyndns.org/')
  local result url

  for url in ${list[*]}; do

    if result=$(curl --max-time 1 -s "${url}"); then
      echo "$result"
      break
    fi
  done
}

