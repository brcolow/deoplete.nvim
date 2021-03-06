"=============================================================================
" FILE: mapping.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
" License: MIT license
"=============================================================================

function! deoplete#mapping#_init() abort "{{{
  inoremap <silent> <Plug>(deoplete_start_complete)
        \ <C-r>=deoplete#mapping#_do_complete(g:deoplete#_context)<CR>
  inoremap <silent> <Plug>(deoplete_auto_refresh)
        \ <C-r>=deoplete#refresh()<CR>
endfunction"}}}

function! deoplete#mapping#_do_complete(context) abort "{{{
  if b:changedtick == get(a:context, 'changedtick', -1)
        \ && mode() ==# 'i'
    if a:context.event ==# 'InsertEnter'
      undojoin
    endif
    call complete(a:context.complete_position + 1, a:context.candidates)
  endif

  return ''
endfunction"}}}
function! deoplete#mapping#_set_completeopt() abort "{{{
  if exists('g:deoplete#_saved_completeopt')
    return
  endif
  let g:deoplete#_saved_completeopt = &completeopt
  set completeopt-=longest
  set completeopt+=menuone
  set completeopt-=menu
  if &completeopt !~# 'noinsert\|noselect'
    set completeopt+=noselect
  endif
endfunction"}}}
function! deoplete#mapping#_rpcnotify_wrapper(sources) abort "{{{
  call rpcrequest(g:deoplete#_channel_id,
        \ 'deoplete_manual_completion_begin',
        \ deoplete#init#_context('Manual', a:sources))
  return ''
endfunction"}}}

" vim: foldmethod=marker
