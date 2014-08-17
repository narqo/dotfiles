# fish git prompt
set __fish_git_prompt_showdirtystate "yes"
set __fish_git_prompt_showupstream "yes"
set __fish_git_prompt_color_branch purple

# Status Chars
set __fish_git_prompt_char_dirtystate "±"
set __fish_git_prompt_char_cleanstate ""
set __fish_git_prompt_char_stagedstate "→"
set __fish_git_prompt_char_invalidstate "✖"
set __fish_git_prompt_char_upstream_ahead "↑"
set __fish_git_prompt_char_upstream_behind "↓"
set __fish_git_prompt_char_upstream_equal ""
set __fish_git_prompt_char_untrackedfiles "…"

function fish_prompt
   set_color red
   printf "%s" (hostname|cut -d . -f 1)
   set_color normal
   printf " £ "

   set_color $fish_color_cwd
   printf "%s" (prompt_pwd)

   set_color normal
   set -l git_prompt_format " ⤳  %s"
   printf "%s" (__fish_git_prompt $git_prompt_format)

   set_color normal

   # Line 2
   echo
   if test $VIRTUAL_ENV
       printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
   end
   printf "  › "
   set_color normal
end
