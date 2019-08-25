set t_Co=256
set nocompatible 	" be iMproved

" to view variable mappings, run => :verbose set variable1? [(variable2)? (variable3)? etc.]

" vim-plug => see ~/.vim/autoload/plug.vim
call plug#begin('~/.vim/plugged')
" Syntax highlighting & filetype detection now handled by vim-plug
" syntax on
" filetype plugin indent on

" utils
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'szw/vim-tags'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'w0ng/vim-hybrid'
Plug 'luochen1990/rainbow'

" Add plugins to &runtimepath
call plug#end()

set background=dark
colorscheme hybrid
hi String ctermfg=228
hi Comment ctermfg=245

map <F2> :mksession! ~/vim_session <CR> 	" write session with F2
map <F3> :source ~/vim_session <CR>   		" load session with F3
map <F4> :let @+=expand("%")<CR>          " grab filename with F4

let mapleader = "\<space>"

" Map 'jk' to the Escape character when in Insert mode
inoremap jk <Esc>
" ^d for forward delete-char
inoremap <C-d> <Del>
nnoremap ; :
" save file
noremap <C-s>  :w<CR>
vnoremap <C-s> <C-C>:w<CR>
inoremap <C-s> <C-O>:w<CR>
" shortcut to command-line in normal mode
nnoremap <Leader>e q:
" setting to get `crontab -e` edits working in mac os
autocmd filetype crontab setlocal nobackup nowritebackup


" vim-closetag + delimitMate config
"     vim-closetag is for xml/html
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.jinja,*.jinja2"
"     turn off delimitMate for those files to avoid double-bracketing
let delimitMate_excluded_ft = "html,xhtml,phtml,xml,jinja,jinja2"

" tell vim to recognize these filetypes, for nerdcommenter and rainbow plugin functionality
au BufNewFile,BufRead *.jinja   setf jinja
au BufNewFile,BufRead *.jinja2  setf jinja2

" pretty-print XML
"     the 'dd' is to remove the XML declaration added to the top
"     extraneous lines are removed, unmatched tags throw error
nnoremap <Leader>x :%!xmllint --format %<CR>dd

" ack.vim config
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>


" nerdcommenter config
"   add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"   use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
"   align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
"   enable trimming of trailing whitespace with uncomment command
let g:NERDTrimTrailingWhitespace = 1


" vim-javascript config
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1


" ctrlp.vim config
"        see :h ctrlp-mappings
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|\.git|vendor|compiled|dist)$'
"        search tag references and choose which to jump to
nnoremap <Leader>g :CtrlPTag<CR>


" easymotion config
let g:EasyMotion_do_mapping = 0 	" Disable default mappings
map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char} (current view only)
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

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
nmap <Leader>n :NERDTreeToggle<CR>	" open NERDTree
nmap <Leader>m :NERDTreeFind<CR>    " find file in tree
" Open NERDTree automatically when Vim starts on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Show hidden files in the tree by default
let NERDTreeShowHidden=1


" rainbow parentheses & html bracket hierarchy color matching on
let g:rainbow_active = 1


" Syntastic config
"  toggle global active/passive mode
map <Leader>c :SyntasticToggleMode<CR>
"  show plugin mode & any checker enabled on the current file
map <Leader>i :SyntasticInfo<CR>
let g:syntastic_go_checkers = ['gofmt']
" add MyPy static type checker for Python
let g:syntastic_python_checkers = ['python', 'pylint', 'mypy']
" show syntax issues from all checkers
let g:syntastic_aggregate_errors=1


" use system clipboard by default instead of '+' or '*' registers for copying & pasting
set clipboard+=unnamedplus

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Turn off highlighting of search results, which is too eager on some commands
" Note that 'n' & 'N' will still jump through results
set nohlsearch

set scrolloff=5

" Disable preview window
set completeopt-=preview

set number              " show line numbers
set wrap                " enable soft line wrap
set textwidth=0         " disable hard line wrap automatic insertion of newlines
set wrapmargin=0
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set inccommand=split    " do incremental substitutions with preview split
set autoindent          " always set autoindenting on
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set cursorline


" language settings
au Bufread,BufNewFile *.raml   setfiletype yaml
au Filetype javascript setl et tabstop=4 shiftwidth=4


" easy navigation between splits to save a keystroke
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" create and quit a window easily
nnoremap <C-N> <C-W><C-N>
nnoremap <Leader>s :vnew<CR>
nnoremap <C-Q> :q<CR>

" move across display lines, not physical lines
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
  nnoremap <Leader>vt :vs term://zsh<CR>
endif

" trigger autoread when changing buffers or coming back to vim
au FocusGained,BufEnter * :silent! !

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" You'll need to run :diffoff to get out of this view, and close the extra window.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Prevent langmap option from applying to characters that result from a
" mapping.  If unset (default), this may break plugins.
if has('langmap') && exists('+langnoremap')
  set langnoremap
endif
