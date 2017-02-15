set t_Co=256
set nocompatible 	" be iMproved

" to view variable mappings, run => :verbose set variable1? [(variable2)? (variable3)? etc.]

" remember to load any remote plugins properly
" :h remote-plugin-manifest

" vim-plug => see ~/.vim/autoload/plug.vim
call plug#begin('~/.vim/plugged')
" Syntax highlighting & filetype detection now handled by vim-plug
" syntax on
" filetype plugin indent on

" utils
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'		" see :h ctrlp-mappings
Plug '~/.vim/plugged/YouCompleteMe'
Plug 'Raimondi/delimitMate'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'szw/vim-tags'

" language-specific
Plug 'jmcantrell/vim-virtualenv'
Plug 'pangloss/vim-javascript'

" style
Plug 'w0ng/vim-hybrid'

" Add plugins to &runtimepath
call plug#end()

set background=dark
colorscheme hybrid


map <F2> :mksession! ~/vim_session <CR> 	" Quick write session with F2
map <F3> :source ~/vim_session <CR>   		" And load session with F3

let mapleader = "\<space>"

" Map 'jk' to the Escape character when in Insert mode
inoremap jk <Esc>
" ^d for forward delete-char
inoremap <C-d> <Del>
nnoremap ; :
" quick save file
noremap <C-s>  :w<CR>
vnoremap <C-s> <C-C>:w<CR>
inoremap <C-s> <C-O>:w<CR>
" shortcut to command-line in normal mode
nnoremap <Leader>e q:


" vim-javascript config
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1


" easymotion config
let g:EasyMotion_do_mapping = 0 	" Disable default mappings
map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char} (current view only)
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" <Leader>s{char}{char} to move to {char}{char} (current view only)
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" search w/easymotion -- use tab/shift+tab to page down/up to view highlighted matches
map  / <Plug>(easymotion-sn)
" complete d/y/c/etc. operator with easymotion search result
omap / <Plug>(easymotion-tn)

" hjkl motions config
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column with JK motion

" case insensitive search
let g:EasyMotion_smartcase = 1


" NERDTree config
nmap <Leader>n :NERDTreeToggle<CR>	" manually open NERDTree
" Open NERDTree automatically when Vim starts on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Show hidden files in the tree by default
let NERDTreeShowHidden=1


" use system clipboard by default instead of '+' or '*' registers for copying & pasting
set clipboard+=unnamedplus

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Turn off highlighting after search with <Esc> key (note that 'n' & 'N' will return highlighted results)
nnoremap <silent> <esc> :noh<CR>

set number              " show line numbers
set wrap                " enable soft line wrap
set textwidth=0         " disable hard line wrap automatic insertion of newlines
set wrapmargin=0
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set autoindent          " always set autoindenting on
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
" set ignorecase        " ignore letter casing in searches (overrides smartcase)


" language settings
au Bufread,BufNewFile *.raml   setfiletype yaml
au Filetype javascript setl et tabstop=4 shiftwidth=4

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

