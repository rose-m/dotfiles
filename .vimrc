set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plug 'mattn/emmet-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Dracula Theme
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

""" General Behavior
" Leave hidden buffers open
set hidden
" Remember last 100 commands
set history=100

""" Finding Files
set path+=**
set wildmenu

""" Editing
" Enable syntax highlighting
syntax enable
set number relativenumber
set numberwidth=3
set textwidth=0
set showcmd
set showmatch
set visualbell
set laststatus=2
" set cursorline
" set clipboard+=unnamed

set ts=4
set sw=4
set et

""" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase

""" Keyboard Shortcuts
map <c-e> :b#<CR>
