" Use Vim settings, rather than Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" PLUGINS
call plug#begin()
" Utils
Plug 'scrooloose/nerdtree'
Plug '~/.vim/plugged/YouCompleteMe'
Plug 'Raimondi/delimitMate'
Plug 'ternjs/tern_for_vim'
" Add plugins to &runtimepath
call plug#end()


map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>   	" And load session with F3

let mapleader = ","

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

" Show line numbers?
" set number

" Map 'jk' to the Escape character when in Insert mode
inoremap jk <Esc> 

nnoremap ; :

" use system clipboard by default instead of '+' or '*' registers for copying & pasting
set clipboard+=unnamedplus

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
 
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands 
set incsearch           " do incremental searching
set autoindent          " always set autoindenting on

" turn off highlighting after search with <Esc> key (note that 'n' & 'N' will return highlighted results)
nnoremap <silent> <esc> :noh<cr>

" easy navigation between splits to save a keystroke
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" escape terminal mode with <Esc> key
if exists(':terminal')
  tnoremap <Esc> <C-\><C-n>
endif

" open new split panes to right and bottom, more natural than Vim’s default
set splitbelow
set splitright

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

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

