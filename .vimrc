set t_Co=256
set nocompatible 	" be iMproved

" remember to load any remote plugins properly
" :h remote-plugin-manifest

" vim-plug => see ~/.vim/autoload/plug.vim
call plug#begin('~/.vim/plugged')

" utils
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'		" see :h ctrlp-mappings
Plug '~/.vim/plugged/YouCompleteMe'
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'szw/vim-tags'
Plug 'jmcantrell/vim-virtualenv'

" style
Plug 'w0ng/vim-hybrid'

" Add plugins to &runtimepath
call plug#end()

set background=dark
colorscheme hybrid


map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>   	" And load session with F3

let mapleader = ","

" Map 'jk' to the Escape character when in Insert mode
inoremap jk <Esc>
" ^d for forward delete-char
inoremap <C-d> <Del>
nnoremap ; :

" Command to manually open NERDTree
nmap <Leader>n :NERDTreeToggle<CR>
" Open NERDTree automatically when Vim starts on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Show hidden files in the tree by default
let NERDTreeShowHidden=1

" Syntax highlighting & filetype detection - now handled by vim-plug
" syntax on
" filetype plugin indent on

" Show line numbers
set number

" Jump to definition using Tern (JavaScript Only)
" YouCompleteMe's implementation is not working, at least for JS
" See :h youcompleteme-goto-commands
nnoremap <leader>jd :TernDef<CR>

" use system clipboard by default instead of '+' or '*' registers for copying & pasting
set clipboard+=unnamedplus

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set autoindent          " always set autoindenting on
set ignorecase		" ignore letter casing in searches

" Turn off highlighting after search with <Esc> key (note that 'n' & 'N' will return highlighted results)
nnoremap <silent> <esc> :noh<cr>

" Easy navigation between splits to save a keystroke
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move across display lines, not physical lines
noremap j gj
noremap gj j
noremap k gk
noremap gk k
noremap <down> gj
noremap <up> gk

set splitbelow
set splitright

" enable mouse
if has('mouse')
  set mouse=a
endif

" neovim
if has('nvim')
  " escape terminal mode with 'jk' or <Esc>
  tnoremap jk <C-\><C-n>
  tnoremap <Esc> <C-\><C-n>
  " Use these only with emacs bindings in the terminal
  " tnoremap <C-h> <C-\><C-n><C-w>h
  " tnoremap <C-j> <C-\><C-n><C-w>j
  " tnoremap <C-k> <C-\><C-n><C-w>k
  " tnoremap <C-l> <C-\><C-n><C-w>l

  " vmap <Leader>e y<C-l>p
  " nmap <Leader>e vipy<C-l>p
  nnoremap <Leader>t :e term://zsh<CR>
  " :vs | term<CR> works great in nvim for new terminal in vertical window
  " starting in INSERT mode, but when run by the shell at startup the pipe
  " causes a parse error, so we settle for:
  nnoremap <Leader>vt :vs term://zsh<CR>
  " nmap <Leader>l :let @r = '(enter! ' . '"' . expand("%") . '")'<CR><C-l>"rpa<CR>
endif

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" You'll need to run :diffoff to get out of this view and close the extra window.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Prevent that the langmap option applies to characters that result from a
" mapping.  If unset (default), this may break plugins (but it's backward
" compatible).
if has('langmap') && exists('+langnoremap')
  set langnoremap
endif

