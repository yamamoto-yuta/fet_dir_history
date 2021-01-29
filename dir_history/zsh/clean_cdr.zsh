#!/bin/zsh
if [ -f "$HOME/.chpwd-recent-dirs" ]; then
  local dirs=""
  cat ~/.chpwd-recent-dirs \
    | sed -e 's/^..\(.*\)./\1/g' \
    | while read line
  do
    if [ -d "$line" ]; then
      dirs=$(echo "\$'$line'")"\n"$dirs
    fi
  done
  dirs=$(echo $dirs | grep -v '^$')
  echo $dirs >| ~/.chpwd-recent-dirs
else
  echo '~/.chpwd-recent-dirs do not exists.'
fi
