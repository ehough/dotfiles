#!/usr/bin/env bash

__prompt_jobs() {

  local -r job_count="$(jobs | wc -l | awk '{ print $1 }')"

  if [[ "$job_count" != '0' ]]; then
    printf "\033[5m\033[93m($job_count)\033[0m " #blinking light yellow
  fi
}

__prompt_last_status_color() {

  if [[ "$LAST_EXIT" != '0' ]]; then
    printf "\033[1;91m" # red
  else
    printf "\033[1;32m" # green
  fi

}

PROMPT_COMMAND='LAST_EXIT="$?";'
PS1='$(__prompt_jobs)$(__prompt_last_status_color)\u@\h\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\] > '
