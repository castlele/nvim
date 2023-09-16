local Plug = vim.fn['plug#']

vim.call("plug#begin")

   -- MARK: Supportive plugins
   Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
   Plug 'junegunn/fzf.vim'
   Plug 'nvim-lualine/lualine.nvim' -- Statusbarg
   Plug 'kyazdani42/nvim-web-devicons'
   Plug 'ntpeters/vim-better-whitespace'
   Plug 'numToStr/Comment.nvim'
   Plug 'tpope/vim-surround'

   -- MARK: Git
   Plug 'tpope/vim-fugitive'

   -- MARK: Color themes and syntax
   Plug 'joshdick/onedark.vim'
   Plug 'rktjmp/lush.nvim'
   Plug '~/.config/nvim/castlelecs-scheme'

   -- MARK: Telescope
   Plug 'nvim-lua/plenary.nvim'
   Plug 'nvim-lua/popup.nvim'
   Plug 'nvim-telescope/telescope.nvim'

   -- MARK: Lsp server and completions
   Plug 'neovim/nvim-lspconfig'
   Plug('williamboman/mason.nvim', { ['config'] = true })
   Plug 'williamboman/mason-lspconfig.nvim'
   Plug 'hrsh7th/nvim-cmp' -- Completion
   Plug 'L3MON4D3/LuaSnip'
   Plug 'hrsh7th/cmp-nvim-lsp'
   Plug 'folke/neodev.nvim'

   -- MARK: Treesitter
   Plug 'nvim-treesitter/nvim-treesitter'
   Plug 'nvim-treesitter/nvim-treesitter-textobjects'

   -- MARK: Mobile development
   Plug 'cfdrake/vim-pbxproj'
   Plug "~/dev/projects/xvimlua"

   -- MARK: Lua lang
   Plug 'euclidianAce/BetterLua.vim'

   -- MARK: Markdown
   Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })

   -- MARK: File browsing
   Plug 'nvim-neo-tree/neo-tree.nvim'
   Plug 'MunifTanjim/nui.nvim' -- neo tree dependency

vim.call("plug#end")

require("plenary")
require('autocommands')
require('appearance')
require('castlelecs.common_settings')
require('castlelecs.keymap_settings')
require('plugins.markdown_preview')
require('plugins.better_whitespace')
require('plugins.git')
require('plugins.lualine')
require('plugins.telescope')
require('plugins.lsp-configuration')
require('Comment').setup()
require('neodev').setup()
require('castlelecs.swift_imports')
require('castlelecs.case_converter_binding')
---@TODO: update to castlelecs. ... or plugin
require('castlelecs.author_comments_binding')({
    default_author_name="Nikita Semenov"
})
