
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'django.vim'
Bundle 'kchmck/vim-coffee-script'

set number

set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set expandtab

set incsearch

set mouse=a

set nobackup
set nowritebackup
set noswapfile

"highlight search
set hls

"shows the search match while typing
set incsearch

"case insensitive search (unless caps provided)
set ignorecase
set smartcase

"don't need /g after :s or :g
set gdefault

"show autocomplete options in status bar
set wildmenu
set wildmode=list:longest,full

set wildignore=.git,*.pyc,*.pyo,*.exe,*.dll,*.obj,*.o,*.a,*.lib,*.so,*.dylib
set wildignore+=*.ncb,*.sdf,*.suo,*.pdb,*.idb,.DS_Store,*.class,*.psd,*.db
set wildignore+=*.sassc,*.scssc,*.jpg,*.JPG,*.jpeg,*.JPEG,*.png,*.gif
set wildignore+=coffee/*.js,coffee/*.map,node_modules,coffee/*.map
set wildignore+=tiny_mce,media,.sass-cache

set colorcolumn=81
highlight ColorColumn ctermbg=000 guibg=#fff

"hilight current line
set cursorline
hi CursorLine ctermbg=000 cterm=NONE

"use system clipboard
set clipboard^=unnamedplus

"always reload changed file
set autoread

set encoding=utf-8

autocmd BufWritePre * :%s/\s\+$//e

" For full syntax highlighting:
let python_highlight_all=1
syntax on

"set filetype on
filetype on
filetype indent on
filetype plugin on
