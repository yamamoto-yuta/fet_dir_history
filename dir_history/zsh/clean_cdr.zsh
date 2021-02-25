#!/bin/zsh
if [ -f "$HOME/.chpwd-recent-dirs" ]; then
  local dirs=""
  cat ~/.chpwd-recent-dirs \
    | sed -e 's/^..\(.*\)./\1/g' \
    | while read line
  do
    if [ -d "$line" ]; then
      dirs=$dirs"\n"$(echo "\$'$line'")
    fi
  done
  dirs=$(echo $dirs | grep -v '^$')
  echo $dirs >| ~/.chpwd-recent-dirs
  echo "$dirs" | sed -e 's/^..\(.*\)./\1/g' | sed 's:^'"$HOME"':~:1'
fi
