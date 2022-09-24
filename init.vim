" MARK: - load plugins

call plug#begin(stdpath('data') . 'vimplug')
    " Supportive plugins
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'willthbill/opener.nvim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " Color themes and syntax
    Plug 'morhetz/gruvbox'
    Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
    Plug 'vim-syntastic/syntastic'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'joshdick/onedark.vim'

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
nnoremap <leader>C :Colors<CR>
map <C-k> :tabnext<CR>
map <C-j> :tabprev<CR>

" MARK: - Telescope bindings

nnoremap <Leader>; <cmd>lua require'telescope.builtin'.buffers{}<CR>
nnoremap <Leader>O <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <Leader>cs <cmd>lua require'telescope.builtin'.colorscheme{}<CR>

" MARK: - Color theme

lua require('lualine').setup()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set background=dark

colorscheme onedark

