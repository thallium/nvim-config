" setlocal foldmethod=syntax foldlevel=10
packadd termdebug
let g:termdebug_wide = 1
function! Debug()
    call MyCompile(1)
    call TerminalClose()
    :Termdebug %:r
endfunction
nnoremap <F5> :call Debug()<CR>
hi debugPC term=reverse ctermbg=lightblue guibg=#4C566A
hi debugBreakpoint term=reverse ctermbg=lightred guibg=#BF616A
