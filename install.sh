#!/usr/bin/env bash

for directory in ./*/ ; do

    package=`basename $directory`
    stow -t ~ $package > /dev/null 2>&1
done
