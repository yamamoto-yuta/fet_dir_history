#!/bin/zsh
local dirs=$(cdr -l | sed 's/^[^ ][^ ]*  *//' | sed 's:^~:'"$HOME"':1')
local dirs_exists=""

for dir in `echo $dirs`
do
  if [ -d $dir ]; then
    dirs_exists="$dirs_exists\n$dir"
  fi
  dirs_exists=$(echo "$dirs_exists" | grep -v "^$" | sed 's:^'"$HOME"':~:1')
done

target_dir=$(echo $dirs_exists | fzf +m --ansi --height 70% --cycle --bind "alt-i:toggle-preview" --info='inline' --layout=reverse --border --prompt="Dir History >" --preview="echo {} | cut -f 2 -d ' ' | xargs -rI{a} sh -c 'if [ -f \"{a}\" ]; then ls -ldhG {a}; if [ \"$(which batcat)\" = \"batcat not found\" ]; then cat {a}; else batcat {a} --color=always --style=grid --line-range :100; fi else ls -ldhG {a}; echo; lsi {a}; fi'")
target_dir=`echo ${target_dir/\~/$HOME}`
if [ -n "$target_dir" ]; then
    _fet_path_selected_path=$target_dir
    . ~/.fet/function/cd.zsh
fi
