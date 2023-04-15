"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them
set tabstop=4 softtabstop=4
set shiftwidth=4
" use 4 spaces instead of tabs during formatting
set expandtab
set smartindent
"---------------------
" Basic editing config
"---------------------
set noerrorbells
set cursorline
set noswapfile   " Don't generate swap files
set encoding=utf-8  " Set encoding to utf-8
set nu " number lines
set incsearch
set smartcase
set backspace=indent,eol,start
set mouse=a

call plug#begin('~/.vim/plugged')
"Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'  " Airline status bar
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme nord
"colorscheme material
"let g:material_theme_style = 'lighter'
set termguicolors

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderPatternMatching = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_conceal_nerdtree_brackets = 1

nnoremap <C-p> :GFiles<Cr>
nnoremap <C-g> :Rg<Cr>
nnoremap <C-b> :NERDTreeToggle<Cr>

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"
