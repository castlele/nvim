local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   -- Color themes and syntax
   { "rktjmp/lush.nvim" },
   { "castlele/castlelecsscheme" },
   { "nvim-lualine/lualine.nvim" }, -- Statusbarg
   { "kyazdani42/nvim-web-devicons" },

   -- Lsp server and completions
   { "neovim/nvim-lspconfig" },
   { "williamboman/mason.nvim" },
   { "williamboman/mason-lspconfig.nvim" },
   { "hrsh7th/nvim-cmp" }, -- Completion
   { "hrsh7th/cmp-nvim-lsp" },
   { "L3MON4D3/LuaSnip" },

   -- Treesitter
   { "nvim-treesitter/nvim-treesitter" },
   { "nvim-treesitter/nvim-treesitter-textobjects" },
   { "nvim-treesitter/playground" },

   -- MARK: Telescope
   { "nvim-lua/plenary.nvim" },
   { "nvim-lua/popup.nvim" },
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         "nvim-telescope/telescope-fzf-native.nvim",
         build = "make",
--         config = function()
--            require("telescope").load_extension("fzf")
--         end,
      },
   },

   -- Supportive plugins
   { "ntpeters/vim-better-whitespace" },
   { "numToStr/Comment.nvim" },

   -- Git
   { "tpope/vim-fugitive" },

   -- Mobile development
   { "cfdrake/vim-pbxproj" }, -- pbxproj syntax highlighting
   { dir = "~/dev/projects/xvimlua" },
   { "udalov/kotlin-vim" },


   -- File browsing
   {
      "nvim-neo-tree/neo-tree.nvim",
      dependencies = {
         { "MunifTanjim/nui.nvim" },
      }
   },
   { "stevearc/oil.nvim" },

   -- Lua lang
   { "euclidianAce/BetterLua.vim" },
   { "folke/neodev.nvim" },

   -- Markdown
   {
      "iamcco/markdown-preview.nvim",
      lazy = true,
      config = function ()
         vim.cmd("!cd app && yarn install")
      end
   },
})

require("autocommands")
require("appearance")
require("plenary")
require("castlelecs.common_settings")
require("castlelecs.keymap_settings")
require("castlelecs.case_converter_binding")
require("castlelecs.author_comments_binding").setup({ default_author_name="Nikita Semenov"})
require("castlelecs.swift_imports")
require("plugins.markdown_preview")
require("plugins.better_whitespace")
require("plugins.git")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.lsp-configuration")
require("plugins.comment")
require("plugins.oil_configuration")
require("neodev").setup()
