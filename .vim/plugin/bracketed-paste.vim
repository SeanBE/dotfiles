" https://coderwall.com/p/if9mda

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux wrapping borrowed from vitality.vim: https://github.com/sjl/vitality.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This fixes pasting from iterm (and some other terminals) by using "bracketed paste mode"
" aaronjensen modified it to work in tmux and not wait for esc
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
