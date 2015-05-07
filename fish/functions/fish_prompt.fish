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

#                 1      2         3          4      5      6      7      8       9      10     11     12
# colors:         black  dark_gray light_gray white  yellow orange red    magenta violet blue   cyan   green
set __fish_colors 000000 083743    445659     fdf6e3 b58900 cb4b16 dc121f af005f  6c71c4 268bd2 2aa198 859900

function __fish_prompt_symbols -d "Display symbols"
  #set_color -b $__fish_colors[2]
  # indicator for vim parent process
  if set -q -x VIM
    set_color -o $__fish_colors[9]
    echo -n " V"
  end
  # indicator for ranger parent process
  if set -q -x RANGER_LEVEL
    set_color -o $__fish_colors[9]
    echo -n " R"
  end
  # background job indicator
  if [ (jobs | wc -l)  -gt 0 ]
    set_color -o $__fish_colors[11]
    echo -n " 🐾"
  end
  # write protection indicator
  if [ ! -w . ]
    set_color -o $__fish_colors[6]
    echo -n " 🔒"
  end
  echo -n " "
  set_color -b normal
end

function fish_prompt
  set_color red
  printf "%s" (hostname|cut -d . -f 1)
  set_color normal
  echo -n -s " £ "

  set_color $fish_color_cwd
  printf "%s" (prompt_pwd)

  set_color normal
  set -l git_prompt_format " ⤳  %s"
  printf "%s" (__fish_git_prompt $git_prompt_format)

  set_color normal

  # Line 2
  echo
  echo -n -s "  › "
  set_color normal
end

function fish_right_prompt
  set -l ps_symbols (__fish_prompt_symbols)
  echo -n -s "$ps_symbols"
end
