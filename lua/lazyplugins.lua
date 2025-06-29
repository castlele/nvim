return {
   -- TODO: Add abilityes:
   -- 1. evaluate math (like here: https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/operators.lua#L768)
   -- 2. can I update default match algorithm for telescope. As stated [here](https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/pick.lua) it is slower than mini.picker itself
   -- 3. try [mini.colors](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-colors.md)
   colorScheme = {
      { "rktjmp/lush.nvim" },
      { dir = "~/.config/castlelecsscheme" },
      { "nvim-lualine/lualine.nvim" }, -- Statusbarg
      { "nvim-tree/nvim-web-devicons" },
   },

   lsp = {
      { "neovim/nvim-lspconfig" },
      {
         "mason-org/mason.nvim",
         version = "v1.32.0",
      },
      {
         "mason-org/mason-lspconfig.nvim",
         version = "v1.32.0",
      },
      { "hrsh7th/nvim-cmp" }, -- Completion
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
   },

   treesitter = {
      {
         "nvim-treesitter/nvim-treesitter",
         version = "v0.9.3",
         dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "nvim-treesitter/playground" },
         },
      },
   },

   git = {
      -- TODO: Research setup
      { "lewis6991/gitsigns.nvim" },
   },

   textNavigation = {
      {
         -- TODO: Setup keymaps + update colorscheme for selections to be visible
         "echasnovski/mini.map",
         version = "*",
      },
      {
         "stevearc/oil.nvim",
         version = "v2.10.0",
      },
      {
         -- TODO: Reasearch configuration and usage
         "folke/todo-comments.nvim",
         dependencies = { "nvim-lua/plenary.nvim" },
         opts = {},
      },
      {
         "nvim-telescope/telescope.nvim",
         dependencies = {
            {
               "nvim-telescope/telescope-live-grep-args.nvim",
               version = "^1.0.0",
            },
            {
               "nvim-telescope/telescope-fzf-native.nvim",
               build = "make",
            },
         },
      },
      {
         "chentoast/marks.nvim",
         event = "VeryLazy",
         opts = {},
      },
   },

   textEditing = {
      -- TODO: Research configuration and usage
      { "numToStr/Comment.nvim" },
      {
         -- better terminal suppport
         "akinsho/toggleterm.nvim",
         version = "*",
         config = true,
      },
      { "ntpeters/vim-better-whitespace" },
      {
         -- TODO: This is cool, but I don't use it, reimagine its configuration to be simplier or remove plugin
         -- While adopting this plugin you can consider using [mini align](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md)
         "Vonr/align.nvim",
         branch = "v2",
         lazy = true,
      },
      -- TODO: Research and make me actually use it, it is so cool
      { "Wansmer/treesj" }, -- toggling indentations
   },

   codding = {
      { "castlele/build.nvim" },
   },

   languages = {
      {
         "nvim-neorg/neorg",
         ft = "norg",
         lazy = false,
         version = "v9.2.0",
         config = function()
            require("plugins.neorg-configuration")
            vim.wo.foldlevel = 99
         end,
      },
      {
         -- pbxproj syntax highlighting
         "cfdrake/vim-pbxproj",
         ft = "pbxproj",
      },
      {
         -- Support for vim api completions
         "folke/neodev.nvim",
         ft = "lua",
      },
      -- TODO: Can I use formatters from mason
      {
         -- stylua formatter wrapper
         "ckipp01/stylua-nvim",
         ft = "lua",
      },

      {
         "iamcco/markdown-preview.nvim",
         cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
         },
         build = "cd app && yarn install",
         init = function()
            vim.g.mkdp_filetypes = { "markdown" }
         end,
         ft = { "markdown" },
      },
   },

   commonDependencies = {
      { "nvim-lua/plenary.nvim" },
   },
}
