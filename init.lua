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
    Plug 'joshdick/onedark.vim'
    Plug 'rktjmp/lush.nvim'
    Plug '~/.config/nvim/castlelecs-scheme'

    -- MARK: Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    -- MARK: Lsp server
    Plug('neoclide/coc.nvim', {branch = 'release'})

    -- MARK: Treesitter
    Plug 'nvim-treesitter/nvim-treesitter'

    -- MARK: Mobile development
    Plug 'cfdrake/vim-pbxproj'
    Plug 'udalov/kotlin-vim'

    -- MARK: Lua lang
    Plug 'euclidianAce/BetterLua.vim'

    -- MARK: Markdown
    Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })

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
require('castlelecs.swift_imports')
require('castlelecs.case_converter_binding')
require('castlelecs.xvim_binding')
require('castlelecs.author_comments_binding')({
    default_author_name="Nikita Semenov"
})
