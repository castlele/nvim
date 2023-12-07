local Plug = vim.fn['plug#']

vim.call('plug#begin')

   -- MARK: Supportive plugins
   Plug 'ntpeters/vim-better-whitespace'
   Plug 'numToStr/Comment.nvim'
   Plug 'tpope/vim-surround'

   -- MARK: Git
   Plug 'tpope/vim-fugitive'

   -- MARK: Color themes and syntax
   Plug 'joshdick/onedark.vim'
   Plug 'rktjmp/lush.nvim'
   Plug 'arzg/vim-colors-xcode'
   Plug '~/.config/nvim/castlelecsscheme'
   Plug 'nvim-lualine/lualine.nvim' -- Statusbarg
   Plug 'kyazdani42/nvim-web-devicons'

   -- MARK: Telescope
   Plug 'nvim-lua/plenary.nvim'
   Plug 'nvim-lua/popup.nvim'
   Plug 'nvim-telescope/telescope.nvim'
   Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
   Plug 'junegunn/fzf.vim'

   -- MARK: Lsp server and completions
   Plug 'neovim/nvim-lspconfig'
   Plug('williamboman/mason.nvim', { ['config'] = true })
   Plug 'williamboman/mason-lspconfig.nvim'
   Plug 'hrsh7th/nvim-cmp' -- Completion
   Plug 'hrsh7th/cmp-nvim-lsp'
   Plug 'L3MON4D3/LuaSnip'

   -- MARK: Treesitter
   Plug 'nvim-treesitter/nvim-treesitter'
   Plug 'nvim-treesitter/nvim-treesitter-textobjects'
   Plug 'nvim-treesitter/playground'

   -- MARK: Mobile development
   Plug 'cfdrake/vim-pbxproj' -- pbxproj syntax highlighting
   Plug '~/dev/projects/xvimlua'
   Plug 'udalov/kotlin-vim'

   -- MARK: Lua lang
   Plug 'euclidianAce/BetterLua.vim'
   Plug 'folke/neodev.nvim'

   -- MARK: Markdown
   Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })

   -- MARK: File browsing
   Plug 'nvim-neo-tree/neo-tree.nvim'
   Plug 'MunifTanjim/nui.nvim' -- neotree dependency

vim.call('plug#end')

require('autocommands')
require('appearance')
require('plenary')
require('castlelecs.common_settings')
require('castlelecs.keymap_settings')
require('castlelecs.case_converter_binding')
require('castlelecs.author_comments_binding').setup({ default_author_name='Nikita Semenov'})
require('castlelecs.swift_imports')
require('plugins.markdown_preview')
require('plugins.better_whitespace')
require('plugins.git')
require('plugins.lualine')
require('plugins.telescope')
require('plugins.lsp-configuration')
require('plugins.comment')
require('neodev').setup()
