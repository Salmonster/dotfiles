set t_Co=256
set nocompatible 	" be iMproved

" To view variable mappings, run => :echo {variable1} [{variable2} {variable3} etc.]
"   Set and unset variables with let/unlet.
" To view option settings, run => :set {option}? ... cf. https://stackoverflow.com/a/12060528/5282936
" To see where an option was set, run => :verbose set {option}

" Remember to install https://github.com/universal-ctags/ctags for support of tags across many languages.
" If you see cross-project GoToDef jumps despite a local .git/tags file, check that there's no ~/tags file screwing things up.

" Run :checkhealth after installing all plugins.

" vim-plug => https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" Syntax highlighting & filetype detection handled by vim-plug
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'szw/vim-tags'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
" The 'for' option here loads CoC only for .ts & .tsx files. Once loaded though
" it'll be in effect for other file types too which changes word completion behavior.
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['typescript', 'typescriptreact']}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'w0ng/vim-hybrid'
Plug 'luochen1990/rainbow'

" Add plugins to &runtimepath
call plug#end()

set background=dark
colorscheme hybrid
hi String ctermfg=228
hi Comment ctermfg=245

map <F2> :mksession! ~/vim_session <CR>   " write session with F2
map <F3> :source ~/vim_session <CR>       " load session with F3
map <F4> :let @+=expand("%")<CR>          " grab filename with F4
map <F5> :DeleteHiddenBuffers<CR>         " delete hidden buffers with F5

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
"     extraneous lines are removed unless the XML is visually selected
"     unmatched tags throw error
"     BUFFER MUST BE SAVED AS FILE (any type) FOR IT TO WORK
nnoremap <Leader>x :%!xmllint --format %<CR>dd

" pretty-print JSON
nnoremap <Leader>q :%!python -m json.tool<CR>

" ack.vim config
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:ack_mappings = {
      \  'v':  '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
      \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' }


" nerdcommenter config
"   add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"   use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
"   align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
"   enable trimming of trailing whitespace with uncomment command
let g:NERDTrimTrailingWhitespace = 1


" vim-airline config
let g:airline_theme='tomorrow'


" vim-go config
"   show :GoTest output in a new term window; see :h gotest
"   NOTE: output in vim isn't as verbose as running `go test` from the terminal
let g:go_term_enabled = 1


" vim-javascript config
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" ~~~ BEGIN TypeScript config
" coc-nvim requires installing coc extensions for language servers:
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-json'
    \ ]
" Minimalist config, adapted from https://github.com/neoclide/coc.nvim#example-vim-configuration

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use <c-space> to refresh completion list
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Show all diagnostics of current buffer in location list
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" ~~~ END TypeScript config


" disable Perl support, avoid health check warning
let g:loaded_perl_provider = 0

" ctrlp.vim config
"        see :h ctrlp-mappings
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|\.git|vendor|compiled|dist)$'
"   scan for dotfiles and dotdirs
let g:ctrlp_show_hidden = 1
"   search tag references and choose which to jump to
nnoremap <Leader>g :CtrlPTag<CR>

" let g:vim_tags_ignore_files = [] " default is ignore files listed in VCS .ignore files
"   Fyi '.env/' in .gitignore won't stop tags being generated from that dir but '.env' will!
let g:vim_tags_auto_generate = 0 " default is 1, generate on file-save
map <Leader>t :TagsGenerate!<CR>
" vim-tags plugin sets 'tags' option for tags files to check in specified order without option to change
"   it via a plugin setting; cf. :verbose set tags & https://stackoverflow.com/a/17688716/5282936
"   If it becomes necessary, can be overridden in an 'after-directory'.
" set tags = .git/tags,./tags,tags,~/tags
let g:python_host_prog = expand('~/.pyenv/shims/python')
let g:python3_host_prog = expand('~/.pyenv/shims/python3')

" easymotion config
let g:EasyMotion_do_mapping = 0 	" Disable default mappings
map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char} (current view only)
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
""
" Until https://github.com/easymotion/vim-easymotion/issues/408 is fixed for post-0.4.0
" versions of Neovim, use this workaround to search for text from clipboard:
map <Leader>f <Plug>(easymotion-sn)<C-R>*

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
set nopaste             " avoid paste mode when copying from external sources
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

" swap ' and ` for easier jump-to-mark instead of jump-to-line-of-mark
noremap ' `
noremap ` '

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
