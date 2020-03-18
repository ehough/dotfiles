#!/usr/bin/env bash

function is_executable() {

  command -v "$1" > /dev/null 2>&1 && return 0 || return 1
}

function is_macos() {

  [[ "$OSTYPE" = 'darwin'* ]] && return 0 || return 1
}
