#!/usr/bin/env bash

function __ssh_sock_setup() {

  local candidate

  # if we don't already have an SSH_AUTH_SOCK, let's try to find an existing one
  if [[ -z "$SSH_AUTH_SOCK" ]] && is_executable ssh-add; then

    # find all possible agent sockets and loop over them most-recent first
    for candidate in $(find /tmp/ssh-* -type s -name "agent.*" -printf "%T@ %p\n" 2> /dev/null | sort -rn | cut -d " " -f 2); do

      # if this agent has keys, let's use it
      if SSH_AUTH_SOCK="$candidate" ssh-add -l 2> /dev/null > /dev/null; then

          export SSH_AUTH_SOCK="$candidate"
          export SSH_AGENT_PID=$(($(echo "$SSH_AUTH_SOCK" | cut -d . -f 2) + 1))
          break
      fi
	  done
  fi
}

__ssh_sock_setup
unset -f __ssh_sock_setup
