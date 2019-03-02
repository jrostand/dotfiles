set nocompatible
filetype off

if has('nvim')
  call plug#begin('~/.vim/plugged')
  source ~/.config/nvim/Vimfile " Load our Plug plugins from an external file
  call plug#end()

  set background=dark
  colorscheme base16-default-dark

  if exists("$TMUX")
    set termguicolors
  endif
else
  colorscheme default
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
set wm=10
set lazyredraw

" " Tabs

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" " Listchars
set list
set listchars=tab:→\ ,extends:»,precedes:«,nbsp:·,trail:·

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
filetype plugin indent on
syntax on

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

augroup configgroup
  " Custom file types
  autocmd BufNewFile,BufRead *.apimd set filetype=apiblueprint  " API Blueprint
  autocmd BufNewFile,BufRead *.md set filetype=markdown         " Markdown
  autocmd BufNewFile,BufRead Guardfile set filetype=ruby        " Guardfile

  " Local filetype overrides
  autocmd Filetype apiblueprint setlocal noet ts=4 sw=4 sts=4
  autocmd Filetype make setlocal noet ts=4 sw=4 sts=4
augroup END

" Mapping

let mapleader = ','
let maplocalleader = '-'
set backspace=indent,eol,start

cabbrev h vert to h

nnoremap <Leader>bb :buffers<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>

nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>s :sort<CR>
nnoremap <Leader>t :NERDTree<CR>

nnoremap <Leader>B :Gblame<CR>
nnoremap <Leader>D :Gdiff<CR>
nnoremap <Leader>W :%s/\s\+$//g<CR>

" System clipboard copy/paste
vnoremap <Leader>c "+y
nnoremap <Leader>v "+gP

if has('nvim')
  " Undotree
  nnoremap <Leader>u :UndotreeToggle<CR>

  " For quick additions to vimrc
  nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
  nnoremap <Leader>eV :vsplit $HOME/.config/nvim/Vimfile<CR>

  " vim-racer
  let g:racer_cmd = $HOME . "/bin/racer"

  " ack.vim
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

  " ctrlp
  let g:ctrlp_match_window = 'bottom,order:ttb'
  let g:ctrlp_switch_buffer = 'e'
  let g:ctrlp_working_path_mode = 'ra'
  if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob "" --hidden'
  elseif executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  endif

  " coc.nvim
  nnoremap <Leader>Cd :CocDisable<CR>
  nnoremap <Leader>Ce :CocEnable<CR>
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  " Rebind syntax-aware completion to C-Tab
  inoremap <C-Tab> <C-x><C-o>

  " NERDTree
  let NERDTreeMinimalUI = 1
endif
