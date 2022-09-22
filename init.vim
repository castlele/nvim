" MARK: - load plugins

call plug#begin(stdpath('data') . 'vimplug')
    " Supportive plugins
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'willthbill/opener.nvim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Color themes
    Plug 'chriskempson/base16-vim'
    Plug 'morhetz/gruvbox'
    Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    Plug 'vim-syntastic/syntastic'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " lsp server
    Plug 'neovim/nvim-lspconfig'
    Plug 'prabirshrestha/async.vim'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'prabirshrestha/vim-lsp'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter'
    
    " Java lang
    Plug 'mfussenegger/nvim-jdtls'
    Plug 'artur-shaik/jc.nvim'
    Plug 'uiiaoo/java-syntax.vim'
   
    " Swift lang
    Plug 'Shougo/deoplete.nvim'
    Plug 'mitsuse/autocomplete-swift'
    Plug 'landaire/deoplete-swift'
    Plug 'kballard/vim-swift'
    Plug 'keith/swift.vim'
    Plug 'tami5/swift.nvim'
    Plug 'aciidb0mb3r/SwiftDoc.vim'
    Plug 'kentaroi/ultisnips-swift'
    "Plug 'xbase-lab/xbase', { 'do': 'make install' }
call plug#end()

" MARK: - Color theme

colorscheme OceanicNext

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" MARK: - Swift setup

let g:tagbar_type_swift = {
  \ 'ctagstype': 'swift',
  \ 'kinds' : [
    \ 'e:Enums',
    \ 't:Typealiases',
    \ 'p:Protocols',
    \ 's:Structs',
    \ 'c:Classes',
    \ 'f:Functions',
    \ 'v:Variables',
    \ 'E:Extensions',
    \ 'l:Constants',
  \ ],
  \ 'sort' : 0
  \ }

if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

autocmd FileType swift setlocal omnifunc=lsp#complete

" MARK: - XBase setup

"lua require('xbase').setup()
"lua require('xbase.statusline').feline()

" MARK: - Java setup

lua require('jc').setup{}

autocmd FileType java setlocal omnifunc=javacomplete#complete

nnoremap <C-j> <cmd>lua require('jc.jdtls').organize_imports()<CR>

" MARK: - basic settings

syntax on
set number
set relativenumber
set ignorecase      " ignore case
set smartcase     " but don't ignore it, when search string contains uppercase letters
set incsearch        " do incremental searching
set visualbell
set expandtab
set tabstop=4
set ruler
set smartindent
set shiftwidth=4
set hlsearch
set virtualedit=all
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent
set mouse=a  " mouse support
set noswapfile

let g:mapleader=","

nnoremap <leader>pv :wincmd v<bar> :e . <bar> :vertical resize 30<CR>
nnoremap <leader>nh :noh<CR>
nnoremap <leader>F :Ag<CR>
map <C-k> :tabnext<CR>
map <C-j> :tabprev<CR>

" MARK: - Telescope bindings

nnoremap <Leader>; <cmd>lua require'telescope.builtin'.buffers{}<CR>
nnoremap <Leader>O <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <Leader>cs <cmd>lua require'telescope.builtin'.colorscheme{}<CR>
