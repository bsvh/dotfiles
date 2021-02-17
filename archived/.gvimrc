" GUI Options {{{
set guifont=Source\ Code\ Pro\ Medium\ 7
set guioptions-=m " don't show the menu bar
set guioptions-=T " don't show the toolbar
set guioptions-=r " don't show the right scroll bar
set guioptions-=L " don't show the left scroll bar
set background=dark                     " use dark version of Solarized
" }}}

" Functions {{{
if has("unix")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
endif
" }}}

" Keymapping {{{
" set hotkeys to increase/decrease font size to CTRL-<up>/<down>
nnoremap <C-Up> :silent :call FontSizePlus()<CR>
nnoremap <C-Down> :silent :call FontSizeMinus()<CR>

" Insert a literal tab. Although <C-Tab> works in GUI, it is best to keep
" keybindings the same between vim and gvim.
let g:SuperTabMappingTabLiteral = <C-Space>
" }}}

" vim:foldmethod=marker:foldlevel=0
