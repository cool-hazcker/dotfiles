set nocompatible 
"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them
set tabstop=4 softtabstop=4
set smartindent
set nowrap
set colorcolumn=100
"---------------------
" Basic editing config
"---------------------
set noerrorbells
set nu " number lines
set incsearch
set smartcase
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
call plug#end()

colorscheme material
let g:material_theme_style = 'lighter'
set termguicolors
