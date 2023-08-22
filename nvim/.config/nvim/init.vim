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
Plug 'elkowar/yuck.vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ActivityWatch/aw-watcher-vim'
Plug 'vim-scripts/indentLine.vim'
Plug 'rhysd/git-messenger.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-easy-align'

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

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

Plug 'lambdalisue/suda.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'kosayoda/nvim-lightbulb'
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

Plug 'norcalli/nvim-colorizer.lua'

Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}


Plug 'uga-rosa/translate.nvim'

Plug 'christoomey/vim-system-copy'
Plug 'eandrju/cellular-automaton.nvim'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'ranjithshegde/ccls.nvim'
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
   let target_path = expand('~/.nvimundodir')

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

let g:coq_settings = {'clients.tabnine.enabled' : v:false}
filetype plugin on
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['bandit', 'python']

" Keybinds
nnoremap <F2> :CHADopen<CR>
set pastetoggle=<F3>
nnoremap <F4> :Goyo<CR>
nnoremap <F5> :MundoToggle<CR>

""Legacy" bindings for cut/copy/paste
imap <C-X> "+x
imap <C-C> "+y
imap <C-V> "+gP



lua << EOF
local lsp = require "lspconfig"
local coq = require "coq" -- add this


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

--lsp.<server>.setup(<stuff...>)                              -- before
--lsp.<server>.setup(coq.lsp_ensure_capabilities(<stuff...>)) -- after

lsp.pyright.setup(coq.lsp_ensure_capabilities({}))
lsp.ccls.setup(coq.lsp_ensure_capabilities({}))
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
}))

EOF

let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha

lua require("catppuccin").setup()
lua require('colorizer').setup()
colorscheme catppuccin

autocmd VimEnter * execute 'COQnow -s'

