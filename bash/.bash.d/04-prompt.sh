#!/usr/bin/env bash

__prompt_jobs() {

  local -r job_count="$(jobs | wc -l)"

  if [[ "$job_count" != '0' ]]; then
    echo -e "\e[5m]\e[93m]($job_count)\e[0m] " #blinking light yellow
  fi
}

__prompt_last_status_color() {

  local color='\e[1;32m' # green

  if [[ "$LAST_EXIT" != '0' ]]; then
    color='\e[1;91m' # red
  fi

  echo -e "$color"
}

PROMPT_COMMAND='LAST_EXIT="$?";'
PS1='$(__prompt_jobs)$(__prompt_last_status_color)\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] > '
