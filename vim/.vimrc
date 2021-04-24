let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-github-dashboard'
Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
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
" Initialize plugin system
call plug#end()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

colorscheme nord
