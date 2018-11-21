" Default settings
set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent
set ruler
set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch
set mouse=a
set lazyredraw
set noshowmode
set noerrorbells
set novisualbell
set nobackup

" Hybrid line numbers
set number
set relativenumber

if has('termguicolors')
  set termguicolors
endif

syntax on
set background=dark

" Use the system clipboard, if possible
set clipboard^=unnamedplus,unnamed

" Make <Leader> more accessible
let mapleader = " "

" Remap Y to y$
nnoremap Y y$

" Window keybinds
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" jk to escape
inoremap jk <Esc>

" Enter to save
nnoremap <CR> :w<CR>

" Paste multiple times without overwriting clipboard
xnoremap p pgvy

" Keep the current visual block selection active after shifting
vmap > >gv
vmap < <gv

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

" Theme
colorscheme hybrid_material
let g:airline_theme = "tomorrow"

" EasyMotion
map <Leader> <Plug>(easymotion-prefix)

"" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Sneak
"" Use one-character Sneak for f and t
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" NERDTree
"" Open automatically when Vim starts up with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"" Close Vim if the only window left open is a NERDTree
autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

" Opam
if executable('opam')
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  execute "set rtp+=" . g:opamshare . "/merlin/vim"

  " Run this line for documentation:
  " :execute "helptags " . g:opamshare . "/merlin/vim/doc"
endif