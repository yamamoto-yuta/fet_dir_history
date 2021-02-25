#!/bin/zsh
target_dir=$(cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf +m --ansi --height 70% --cycle --header="Alt-i:Info Alt-r:Reload" --bind "alt-i:toggle-preview,alt-r:reload:source ~/.fet/plugins/dir_history/zsh/clean_cdr.zsh" --info='inline' --layout=reverse --border --prompt="Dir History >" --preview="echo {} | cut -f 2 -d ' ' | xargs -rI{a} sh -c 'if [ -f \"{a}\" ]; then ls -ldhG {a}; if [ \"$(which batcat)\" = \"batcat not found\" ]; then cat {a}; else batcat {a} --color=always --style=grid --line-range :100; fi else ls -ldhG {a}; echo; lsi {a}; fi'")
target_dir=`echo ${target_dir/\~/$HOME}`
if [ -n "$target_dir" ]; then
  _fet_path_selected_path=$target_dir
  . ~/.fet/function/cd.zsh
fi
