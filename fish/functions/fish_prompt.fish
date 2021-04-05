# fish git prompt
set __fish_git_prompt_showdirtystate "yes"
set __fish_git_prompt_showstashstate "yes"
set __fish_git_prompt_showupstream "yes"
#set __fish_git_prompt_color_branch purple
set __fish_git_prompt_color normal
set __fish_git_prompt_color_branch normal

# Status Chars
set __fish_git_prompt_char_upstream_prefix " "
set __fish_git_prompt_char_cleanstate ""
set __fish_git_prompt_char_dirtystate "±"
set __fish_git_prompt_char_stagedstate "⇈"
set __fish_git_prompt_char_invalidstate "✖"
set __fish_git_prompt_char_stashstate "↩"
set __fish_git_prompt_char_upstream_ahead "↑"
set __fish_git_prompt_char_upstream_behind "↓"
set __fish_git_prompt_char_upstream_equal ""
set __fish_git_prompt_char_untrackedfiles "…"

#                 1      2         3          4      5      6      7      8       9      10     11     12
# colors:         black  dark_gray light_gray white  yellow orange red    magenta violet blue   cyan   green
set __fish_colors 000000 083743    445659     fdf6e3 b58900 cb4b16 dc121f af005f  6c71c4 268bd2 2aa198 859900

function __fish_prompt_symbols -d "Display symbols"
  # background job indicator
  if [ (jobs | wc -l)  -gt 0 ]
    set_color -b $__fish_colors[11]
    echo -n " ⋯ "
    set_color -b normal
  end
  # write protection indicator
  if [ ! -w . ]
    set_color -b $__fish_colors[6]
    echo -n " 𝕷 "
    set_color -b normal
  end
end

function fish_prompt
  set -l exit_code $status

  set -l prompt ""

  # display username and hostname if logged in as root, in sudo or ssh session
  if [ \( (id -u) -eq 0 -o $SUDO_USER \) -o $SSH_CONNECTION ]
    set -l host (hostname | cut -f 1 -d ".")
    set prompt $prompt (set_color $__fish_colors[6])$host(set_color normal)": "
  end

  set prompt $prompt (set_color normal)(pwd | sed "s:^$HOME\/:~/:")
  echo -n -s $prompt (set_color normal)

  set -l git_prompt_format (set_color normal)" 𝒪𝓃 %s"
  echo -n -s (__fish_git_prompt $git_prompt_format)

  # Line 2
  set_color normal
  echo
  echo -s "› "
end

function fish_right_prompt
  set -l ps_symbols (__fish_prompt_symbols)
  echo -n -s "$ps_symbols"
end
