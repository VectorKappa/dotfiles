" Autoinstall vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
call plug#begin('~/.vim/plugged')

Plug 'mattn/webapi-vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'pearofducks/ansible-vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'liuchengxu/vim-which-key'
Plug 'vim-scripts/indentLine.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/limelight.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
"Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'sheerun/vim-polyglot'
Plug 'mbbill/undotree'
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

" Initialize plugin system
call plug#end()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
filetype plugin on
colorscheme nord
"Keybinds
set pastetoggle=<F3>
