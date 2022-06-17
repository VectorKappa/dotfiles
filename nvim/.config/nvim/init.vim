let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible
" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')
"Undo tree
Plug 'simnalamburt/vim-mundo'

"""""REQUIRED LIBRARIES"""""
""For :RustPlay via polyglot/syntastic
Plug 'mattn/webapi-vim'

"""""COMMON SYNTAX CHECKER"""""
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
"""""HTML"""""
Plug 'mattn/emmet-vim'

Plug 'junegunn/vim-github-dashboard'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ActivityWatch/aw-watcher-vim'
Plug 'vim-scripts/indentLine.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/vim-easy-align'

"""""CLUTTER-FREE EDITING"""""
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"""""COMMENTING WITH \c<space>"""""
Plug 'scrooloose/nerdcommenter'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
"Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'bronson/vim-trailing-whitespace'
" I love you tpope <3
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'


Plug 'kosayoda/nvim-lightbulb'
Plug 'antoinemadec/FixCursorHold.nvim'


Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

" Initialize plugin system
call plug#end()


"""""GOYO SETTINGS BLOCK"""""
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'DarkGray'

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"""""
autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'CHADopen' | execute 'cd '.argv()[0] | endif
let g:airline_powerline_fonts = 1
filetype plugin on
colorscheme nord
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['bandit', 'python']
"Keybinds
nnoremap <F2> :CHADopen<CR>
set pastetoggle=<F3>
nnoremap <F4> :Goyo<CR>
nnoremap <F5> :MundoToggle<CR>
map <S-> +p


" Neovim specific settings:
set mouse=a
" Neovide specific settings:

let g:neovide_refresh_rate=60
let g:neovide_input_use_logo=v:false

