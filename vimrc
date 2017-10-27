set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
source ~/.Vimfile " Load our Plug plugins from an external file
call plug#end()

filetype plugin indent on

if exists("$TMUX")
  set term=screen-256color
endif

" Auto-embiggen the GVIM window
if has("gui_running")
  set guioptions=egmrt
  set lines=200 columns=400
endif

" Variables

" " General

set ai
set encoding=utf-8
set nobackup
set noswapfile
set nowrap
set scrolloff=3
set showcmd
set t_Co=256
set wm=10
set lazyredraw

" " Tabs

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" " Direction Finding

set number
set ruler

" " Searching

set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase

" " Syntax and Coloring

set modeline
set background=dark
colorscheme base16-default-dark
syntax on
filetype on
filetype indent on

" " Persistent undo

let vimDir = '$HOME/.vim'

if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undo')
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" " Statusline

set laststatus=2

augroup cofiggroup
  " " Uglify trailing whitespace
  autocmd Syntax * syn match ExtraWhitespace /\s\+$| \+\ze\t/
  highlight ExtraWhitespace ctermbg=red guibg=red

  " " Custom file types

  au BufNewFile,BufRead *.apimd set filetype=apiblueprint	" API Blueprint
  au BufNewFile,BufRead *.md set filetype=markdown        " Markdown
  au BufNewFile,BufRead Guardfile set filetype=ruby       " Guardfile

  " Local filetype overrides

  autocmd Filetype apiblueprint setlocal noet ts=4 sw=4 sts=4
  autocmd Filetype make setlocal noet ts=4 sw=4 sts=4
augroup END

" Mapping

let mapleader = ','
let maplocalleader = '-'
set backspace=indent,eol,start

nnoremap <Leader>. :s/^\s*/&# /<CR>
nnoremap <Leader>m :s/# //<CR>

nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>

nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>s :sort<CR>
nnoremap <Leader>t :NERDTree<CR>
nnoremap <Leader>B :Gblame<CR>
nnoremap <Leader>D :Gdiff<CR>
nnoremap <Leader>W :%s/\s\+$//g<CR>

" Rebind syntax-aware completion to C-Tab
inoremap <C-Tab> <C-x><C-o>

" Undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" RSpec integration
nnoremap <Leader>sa :call RunAllSpecs()<CR>
nnoremap <Leader>sf :call RunCurrentSpecFile()<CR>
nnoremap <Leader>sl :call RunLastSpec()<CR>
nnoremap <Leader>ss :call RunNearestSpec()<CR>

" System clipboard copy/paste
vnoremap <Leader>c "+y
nnoremap <Leader>v "+gP

" For quick additions to vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>eV :vsplit $HOME/.Vimfile<CR>

if has("gui_running")
  nnoremap <Leader>S :source $MYGVIMRC<CR>
else
  nnoremap <Leader>S :source $MYVIMRC<CR>
endif

" vim-rspec
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" vim-racer
let g:racer_cmd = $HOME . "/bin/racer"

" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" ctrlp
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif
