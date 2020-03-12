#!/usr/bin/env bash

__prompt() {

  __prompt_jobs() {

    local -r job_count="$(jobs | wc -l | tr -d '[:space:]')"

    # common case - no bg jobs
    if [[ "$job_count" = '0' ]]; then
      return
    fi

    local -r count_running="$(jobs -r | wc -l | tr -d '[:space:]')"
    local -r count_stopped="$(jobs -s | wc -l | tr -d '[:space:]')"
    local message

    # if all stopped
    if [[ "$count_running" = '0' ]]; then

      message="$count_stopped stopped bg job"
      [[ $count_stopped -gt 1 ]] && message+='s'

    # at least some running
    else

      if [[ "$count_stopped" = '0' ]]; then
        message="$count_running running bg job"
        [[ $count_running -gt 1 ]] && message+='s'
      else
        message="bg jobs: $count_running running, $count_stopped stopped"
      fi

    fi

    echo "($message) "
  }

  __prompt_git() {

    # ideas stolen from: https://github.com/riobard/bash-powerline/blob/master/bash-powerline.sh

    hash git 2>/dev/null || return # git not found

    local -r git_eng='env LANG=C git'
    local -r symbol_git_branch=''
    local -r symbol_git_push='↑'
    local -r symbol_git_pull='↓'
    local -r symbol_modified='*'
    local ref marks line

    ref=$(${git_eng} symbolic-ref --short HEAD 2>/dev/null)

    if [[ -n "${ref}" ]]; then
      # prepend branch symbol
      ref="${symbol_git_branch}${ref}"
    else
      # get tag name or short unique hash
      ref=$(${git_eng} describe --tags --always 2>/dev/null)
    fi

    [[ -n "${ref}" ]] || return  # not a git repo

    # scan first two lines of output from `git status`
    while IFS= read -r line; do

      if [[ ${line} =~ ^## ]]; then # header line

        [[ ${line} =~ ahead\ ([0-9]+) ]] && marks+=" ${symbol_git_push}${BASH_REMATCH[1]}"
        [[ ${line} =~ behind\ ([0-9]+) ]] && marks+=" ${symbol_git_pull}${BASH_REMATCH[1]}"

      else # branch is modified if output contains more lines after the header line

        marks="${symbol_modified}${marks}"
        break
      fi
    done < <(${git_eng} status --porcelain --branch 2>/dev/null)  # note the space between the two <

    # print the git branch segment without a trailing newline
    echo -n " (${ref}${marks})"
  }

  __prompt_ps1() {

    local -r last_exit=$?
    local -r color_reset='\e[m'
    local -r color_success='\e[1;32m' # bold green
    local -r color_failure='\e[1;91m' # bold red
    local -r color_pwd='\e[1;34m'     # bold blue
    local -r color_git='\e[90m'       # dark gray
    local -r color_jobs='\e[93m'      # yellow
    local color_exit git

    [[ ${last_exit} -eq 0 ]] && color_exit="$color_success" || color_exit="$color_failure"

    if shopt -q promptvars; then
      __prompt_git_info="$(__prompt_git)"
      git="\${__prompt_git_info}"
    else
      git="$(__prompt_git)"
    fi

    PS1="${color_jobs}$(__prompt_jobs)${color_exit}\u@\h ${color_pwd}\w${color_git}${git}${color_reset} > "
  }

  PROMPT_COMMAND="__prompt_ps1"
}

__prompt
unset __prompt
