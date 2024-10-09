local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
   })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   -- Color themes and syntax
   { "rktjmp/lush.nvim" },
   { dir = "~/.config/castlelecsscheme" },
   { "nvim-lualine/lualine.nvim" }, -- Statusbarg
   { "kyazdani42/nvim-web-devicons" },

   -- Writing
   {
      "folke/zen-mode.nvim",
      dependencies = {
         { "folke/twilight.nvim" },
      },
   },

   -- Lsp server and completions
   { "neovim/nvim-lspconfig" },
   { "williamboman/mason.nvim" },
   { "williamboman/mason-lspconfig.nvim" },
   { "hrsh7th/nvim-cmp" }, -- Completion
   { "hrsh7th/cmp-nvim-lsp" },
   { "hrsh7th/cmp-buffer" },
   { "hrsh7th/cmp-path" },
   { "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
   {
      -- AI Integration
      "Exafunction/codeium.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "hrsh7th/nvim-cmp",
      },
      config = function()
         require("codeium").setup({
            enable_chat = true,
         })
      end
   },

   -- Treesitter
   { "nvim-treesitter/nvim-treesitter" },
   { "nvim-treesitter/nvim-treesitter-textobjects" },
   { "nvim-treesitter/playground" },

   -- Telescope
   { "nvim-lua/plenary.nvim" },
   { "nvim-lua/popup.nvim" },
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         {
            "nvim-telescope/telescope-live-grep-args.nvim" ,
            version = "^1.0.0",
         },
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
         },
      },
   },

   -- Supportive plugins

   {
      -- TODOs highlighting
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {},
   },
   {
      -- better terminal suppport
      "akinsho/toggleterm.nvim",
      version = "*",
      config = true,
   },
   { "ntpeters/vim-better-whitespace" },
   { "numToStr/Comment.nvim" },
   {
      "vhyrro/luarocks.nvim",
      priority = 1000,
      config = true,
   },
   {
      "nvim-neorg/neorg",
      dependencies = { "luarocks.nvim" },
      lazy = false,
      version = "v8.0.1",
      config = true,
   },
   {
      "Vonr/align.nvim",
      branch = "v2",
      lazy = true,
   },

   -- Git
   { "f-person/git-blame.nvim" },
   { "sindrets/diffview.nvim" },

   -- Mobile development
   { "cfdrake/vim-pbxproj" }, -- pbxproj syntax highlighting
   { dir = "~/dev/projects/xvimlua" },
   { "udalov/kotlin-vim" },
   { "Wansmer/treesj" }, -- toggling indentations

   -- File browsing
   {
      "stevearc/oil.nvim",
      version = "v2.10.0",
   },

   -- Lua lang
   { "euclidianAce/BetterLua.vim" },
   { "folke/neodev.nvim" },

   -- Markdown
   {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
         vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
   },

   -- Puml image creation
   {
      "weirongxu/plantuml-previewer.vim",
      dependencies = {
         "tyru/open-browser.vim"
      },
   },
})

require("autocommands")
require("appearance")
require("plenary")
require("castlelecs.common_settings")
require("castlelecs.keymap_settings")
require("castlelecs.case_converter_binding")
require("castlelecs.author_comments_binding").setup({ default_author_name="Nikita Semenov"})
require("castlelecs.init_declaration_to_usage_binding")
require("castlelecs.imports_sorting")
require("plugins.markdown_preview")
require("plugins.better_whitespace")
require("plugins.git-blame-configuration")
require("plugins.git")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.luasnip")
require("plugins.lsp-configuration")
require("plugins.comment")
require("plugins.oil_configuration")
require("plugins.neorg-configuration")
require("plugins.treesj-configuration")
require("plugins.toggleterm-configuration")
require("plugins.align-configuration")
require("neodev").setup()
