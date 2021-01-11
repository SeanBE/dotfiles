setlocal foldlevel=2
setlocal foldmethod=syntax

if line('$') > 50
   setlocal foldlevel=0
endif
