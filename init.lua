local Plug = vim.fn['plug#']

vim.call("plug#begin")

    -- MARK: Supportive plugins
    Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
    Plug 'junegunn/fzf.vim'
    Plug 'nvim-lualine/lualine.nvim' -- Statusbarg
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'

    -- MARK: Git
    Plug 'tpope/vim-fugitive'

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
    Plug('neoclide/coc.nvim', {branch = 'release'})

    -- MARK: Treesitter
    Plug 'nvim-treesitter/nvim-treesitter'

    -- MARK: Swift and Obj-c lang and Xcode
    Plug 'kballard/vim-swift'
    Plug 'cfdrake/vim-pbxproj'

    -- MARK: Lua lang
    Plug 'euclidianAce/BetterLua.vim'

    -- MARK: Markdown
    Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })

    -- MARK: Terminal
    Plug('akinsho/toggleterm.nvim', { ['tag'] = '*' })

    -- MARK: File browsing

    Plug('nvim-neo-tree/neo-tree.nvim')
    Plug('MunifTanjim/nui.nvim') -- neo tree dependency

vim.call("plug#end")

require('autocommands')
require('appearance')
require('castlelecs.common_settings')
require('castlelecs.keymap_settings')
require('plugins.markdown_preview')
require('plugins.better_whitespace')
require('plugins.git')
require('plugins.lualine')
require('plugins.coc')
require('plugins.telescope')
require('toggleterm').setup()
require('castlelecs.swift_imports')
require('castlelecs.case_converter_binding')
