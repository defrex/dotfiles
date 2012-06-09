
set number

set nocompatible

set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set expandtab

set incsearch

" set mouse=a

" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: ``set encoding=utf-8``
set encoding=utf-8

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Automatically indent based on file type: 
filetype indent on

source ~/.vimrc.d/*
