#                 1      2         3          4      5      6      7       8       9      10      11      12
# colors:         black  dark_gray light_gray white  yellow orange red     magenta violet blue    cyan    green
set __fish_colors 000000 083743    445659     fff    e49535 cb4b16 cc2100  af005f  6c71c4 0c24bf  6db1d0  008000

# fish git prompt
set __fish_git_prompt_showdirtystate "yes"
set __fish_git_prompt_showstashstate "yes"
set __fish_git_prompt_showupstream "yes"
set __fish_git_prompt_color normal
set __fish_git_prompt_color_branch $__fish_colors[1]

# Status Chars
set __fish_git_prompt_char_upstream_prefix " "
set __fish_git_prompt_char_cleanstate ""
set __fish_git_prompt_char_dirtystate "±"
set __fish_git_prompt_char_stagedstate "⇈"
set __fish_git_prompt_char_invalidstate "✖"
set __fish_git_prompt_char_stashstate "⚑"
set __fish_git_prompt_char_upstream_ahead "↑"
set __fish_git_prompt_char_upstream_behind "↓"
set __fish_git_prompt_char_upstream_equal ""
set __fish_git_prompt_char_untrackedfiles "…"

function __fish_prompt_symbols -d "Display symbols"
  # background job indicator
  if [ (jobs | wc -l)  -gt 0 ]
    set_color $__fish_colors[4]
    set_color --background $__fish_colors[11]
    echo -n " ·· "
    set_color normal
  end
  # write protection indicator
  if [ ! -w . ]
    set_color $__fish_colors[4]
    set_color --background $__fish_colors[6]
    echo -n " 𝕷 "
    set_color normal
  end
end

function __vcs_prompt
    __jj_prompt $argv
    or fish_git_prompt $argv
end

function __jj_prompt
    if not command -sq jj
        return 1
    end

    set -l state (command jj log 2>/dev/null -r @ --no-graph --color never --ignore-working-copy \
        --template 'separate("\n", change_id.shortest(8), if(!empty, "1", "0"), if(immutable, "1", "0"))')
    test -n "$state"
    or return

    set -l change_id $state[1]
    set -l infostatus

    # dirty
    if test "$state[2]" = 1
        set infostatus " $__fish_git_prompt_char_dirtystate"
    end

    set -l format $argv[1]
    printf "$format%s" "$change_id$infostatus"
end

function fish_prompt
  set -l last_status $status

  # Line 1
  set -l prefix

  # display username and hostname if logged in as root, in sudo or ssh session
  if [ \( (id -u) -eq 0 -o $SUDO_USER \) -o $SSH_CONNECTION ]
    set -l host (hostname | cut -f 1 -d ".")
    set prefix $prefix (set_color $__fish_colors[6])$host(set_color normal)": "
  end

  set -l pwd_color $__fish_colors[10]
  if test $last_status -ne 0
      set pwd_color --bold $__fish_colors[7]
  end

  set -l pwd (string replace -r '^'"$HOME"'/' '~/' $PWD)
  echo -n -s $prefix (set_color $pwd_color) $pwd (set_color normal)

  set -l vcs_prompt_format (set_color normal)" 𝒪𝓃 %s"
  echo -n -s (__vcs_prompt $vcs_prompt_format)

  set -l ps_symbols (__fish_prompt_symbols)
  if string length -q -- $ps_symbols
    printf ' %s ' $ps_symbols
  end

  echo -s

  # Line 2
  set_color normal
  #echo -s "› "
end

function fish_right_prompt
#  set -l ps_symbols (__fish_prompt_symbols)
#  echo -n -s "$ps_symbols"
end
