" Maintainer:   Marc Weber <marco-oweberNOSPAM@gmx.de>
" original auhtor: Tim Pope

" vam#DefineAndBind('g:vim_addon_commenting','s:c','{}')
if !exists('g:vim_addon_commenting') | let g:vim_addon_commenting = {} | endif | let s:c = g:vim_addon_commenting
let s:c['default_options'] = function('commentary#DefaultOptions')
let s:c['force_filetype_comments'] = get(s:c, 'force_filetype_comments', {})


" must return: { 'mode': MODE, 'comment_strings': CS }
" MODE: one of 'auto|comment|uncomment'
" CS: [start,end], end may be ""
fun! commentary#DefaultOptions() abort

  let force = get(s:c.force_filetype_comments, &filetype, [])
  if force != [] | return {'comment_strings':force} | endif
  

  " fallback to comment_strings but search in comments for the shortest single
  " line comment
  let o = { 'comment_strings':split(&commentstring,"%s",1) }
  for c in split(&comments,',')
    let cs = matchstr(c, ':\zs.*')
    if c =~ '^b\?:' && (!exists('first_only') ||  len(cs) < len(first_only))
      " if item starts by : we've probably found a line comment. Prefer this
      let first_only = cs
    endif
  endfor
  if exists('first_only') | let o.comment_strings = [first_only, ''] | endif
  return o
endfun


" fun: fun returning comments to be used
fun! commentary#CommentLineRange(lnum1, lnum2, action, ...) abort
  let opts = a:0 > 0 ? a:1 : call(s:c['default_options'],[])

  let lnum1 = a:lnum1
  let lnum2 = a:lnum2
  let action = a:action

  let [before, after] = opts.comment_strings
  if action == "auto"
    let action = "uncomment"
    for lnum in range(lnum1,lnum2)
      let line = matchstr(getline(lnum),'\S.*\s\@<!')
      if line !~ '^\s*$' && (stridx(line,before) || line[strlen(line)-strlen(after) : -1] != after)
        let action = "comment"
      endif
    endfor
  endif

  if action == "comment"
    " if cursor is at start of line add markers at indentation level
    let beforeC = matchstr(strpart(getline('.'),0,col('.')-1), '^\s*')
  endif

  for lnum in range(lnum1,lnum2)
    let line = getline(lnum)

    if action == "uncomment"
      let ec = '/\*"'
      " comment: drop before and after. if before is followed by space drop
      " that as well
      let line = substitute(line,'^\(\s*\)'.escape(before, ec).' \?\(.*\)'.escape(after,ec).'\s*$','\1\2','')
    else
      if line !~ '^\s*$'
        let line = substitute(line,'^\('.beforeC.'\)\?\(.*\)', '\1'.before.' \2'.after, '')
      endif
    endif

    call setline(lnum,line)
  endfor

endfun

fun! commentary#GoMove(dummy)
    call commentary#CommentLineRange(line("'["), line("']"), 'auto')
endfun
