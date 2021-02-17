if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  silent !mkdir -p ~/.local/share/nvim/backup ~/.local/share/nvim/swap
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/plugged')

let g:plug_url_format = 'git@github.com:%s.git'
Plug 'bsvh/vim-ftplugins'
Plug 'bsvh/vim_snips'

unlet g:plug_url_format

"Appearance
Plug 'dguo/blood-moon', {'rtp': 'applications/vim'}
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'

" Completion/Snips
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'
Plug 'deoplete-plugins/deoplete-jedi', { 'do': 'pip3 install --user jedi --upgrade' }
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'

" Editing
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/goyo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'Plasticboy/vim-markdown'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'Lenovsky/nuake'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

""" Appearance

" Colors
colorscheme blood-moon
set termguicolors
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

" Status Line
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
set noshowmode

" Editor
set relativenumber
set number
set title
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set splitbelow
set splitright
set textwidth=0
set undofile
set backup
set backupdir=~/.local/share/nvim/backup
set directory=~/.local/share/nvim/swap
set spelllang=en_us
set hidden
set wildmode=longest:list,full
set omnifunc=syntaxcomplete#Complete
set cursorline
set nowrap
set colorcolumn=80
set foldenable
set foldmethod=syntax
set ww=b,s,h,l,<,>,[,]                  " left/right/h/l can change lines

" Search
set hlsearch
set incsearch
set smartcase


let g:black_linelength = 80

let g:deoplete#enable_at_startup = 1
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

""" Keyboard Mappings

" Terminal
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
tmap <C-k> <C-w>k
tmap <C-j> <C-w>j
tmap <C-h> <C-w>h
tmap <C-l> <C-w>l

" Navigation
nmap j gj
nmap k gk
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h 

map <space> <Leader>

" Space bar un-highligts search
noremap <silent> <leader><Space> :silent noh<Bar>echo<CR>

" Writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

" Plugins
nmap <F8> :TagbarToggle<CR>
nnoremap <F4> :Nuake<CR>
inoremap <F4> <C-\><C-n>:Nuake<CR>
tnoremap <F4> <C-\><C-n>:Nuake<CR>
