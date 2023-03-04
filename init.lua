local Plug = vim.fn['plug#']

vim.call("plug#begin")

    -- MARK: Supportive plugins
    -- Plug 'lukas-reineke/indent-blankline.nvim'
    -- Plug 'willthbill/opener.nvim'
    Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
    Plug 'junegunn/fzf.vim'   
    Plug 'nvim-lualine/lualine.nvim' -- Statusbarg
    Plug 'kyazdani42/nvim-web-devicons'

    -- MARK: Color themes and syntax
    Plug 'morhetz/gruvbox'
    Plug 'mhartington/oceanic-next'   -- colorscheme OceanicNext
    Plug 'EdenEast/nightfox.nvim'
    Plug 'joshdick/onedark.vim'

    -- MARK: Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    -- MARK: Lsp server
    Plug 'neovim/nvim-lspconfig'

    -- MARK: Treesitter
    Plug 'nvim-treesitter/nvim-treesitter'
   
    -- MARK: Swift and Obj-c lang
    Plug 'keith/swift.vim'
    Plug 'msanders/cocoa.vim'

    -- MARK: C/C++ lang
    Plug('neoclide/coc.nvim', {branch = 'release'})

    -- MARK: Lua lang
    Plug 'euclidianAce/BetterLua.vim'

vim.call("plug#end")

require('appearance')
require('castlelecs.common_settings')
require('castlelecs.keymap_settings')
require('plugins.coc')
require('plugins.telescope')
require('plugins.lualine')
