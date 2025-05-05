local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
   vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
   }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
   -- Color themes and syntax
   { "rktjmp/lush.nvim" },
   { dir = "~/.config/castlelecsscheme" },
   { "nvim-lualine/lualine.nvim" }, -- Statusbarg
   { "nvim-tree/nvim-web-devicons" },

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
      "zbirenbaum/copilot-cmp",
      config = function()
         require("copilot_cmp").setup()
      end,
   },
   {
      "zbirenbaum/copilot.lua",
      config = function()
         require("copilot").setup {
            suggestion = { enabled = false },
            panel = { enabled = false },
         }
      end,
   },

   -- Treesitter
   {
      "nvim-treesitter/nvim-treesitter",
      version = "v0.9.3",
      dependencies = {
         { "nvim-treesitter/nvim-treesitter-textobjects" },
         { "nvim-treesitter/playground" },
      },
   },

   -- Telescope
   { "nvim-lua/plenary.nvim" },
   { "nvim-lua/popup.nvim" },
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

   -- Supportive plugins

   {
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
      "nvim-neorg/neorg",
      lazy = false,
      version = "v9.2.0",
      config = function()
         require("plugins.neorg-configuration")
         vim.wo.foldlevel = 99
      end,
   },
   {
      "Vonr/align.nvim",
      branch = "v2",
      lazy = true,
   },
   {
      "chentoast/marks.nvim",
      event = "VeryLazy",
      opts = {},
   },
   { "castlele/build.nvim" },

   -- Mobile development
   { "cfdrake/vim-pbxproj" }, -- pbxproj syntax highlighting
   { "udalov/kotlin-vim" },
   { "Wansmer/treesj" }, -- toggling indentations

   -- File browsing
   {
      "stevearc/oil.nvim",
      version = "v2.10.0",
   },

   -- Image rendering
   {
      "3rd/image.nvim",
      build = false,
      opts = {
         processor = "magick_cli",
      }
   },

   -- Lua lang
   { "euclidianAce/BetterLua.vim" },
   { "folke/neodev.nvim" },
   { "ckipp01/stylua-nvim" }, -- stylua formatter wrapper

   -- Zig lang
   { "ziglang/zig.vim" },

   -- Markdown
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

   -- Puml image creation
   {
      "weirongxu/plantuml-previewer.vim",
      dependencies = {
         "tyru/open-browser.vim",
      },
   },
}

require("autocommands")
require("appearance")
require("plenary")
require("castlelecs.common_settings")
require("castlelecs.keymap_settings")
require("castlelecs.case_converter_binding")
require("castlelecs.imports_sorting")
require("plugins.markdown_preview")
require("plugins.better_whitespace")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.luasnip")
-- TODO: Remove this package entirely when default neovim config will replace it
require("plugins.lsp-configuration")
-- require("plugins.new-lsp-configuration")
require("plugins.comment")
require("plugins.oil_configuration")
require("plugins.treesj-configuration")
require("plugins.toggleterm-configuration")
require("plugins.align-configuration")
require("plugins.stylua-nvim-configuration")
require("plugins.image-configuration")
require("neodev").setup()
require("build").setup()
require("castlelecs.obsidian").setup {
   "docs",
   "catscastle",
   "kbase",
}
require("castlelecs.norgtemplate").setup {
   week = {
      MON = {
         "work - 3h",
         "fill stats",
         "prepare next week file",
         "take care of Javie",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      TUE = {
         ["work - 3h"] = {
            "design demo",
         },
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      WED = {
         "work - 3h",
         "clean the floors",
         "clean the office",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      THU = {
         "work - 3h",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      FRI = {
         "psychology session %13:00% - 1h",
         "work - 3h",
         "take care of Javie",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      SAT = {
         "followattr - 1h",
         "comeback - 30m",
         "call to grandmother",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      SUN = {
         "followattr - 1h",
         "comeback - 30m",
         "clean the floors",
         "clean the office",
         "review goals",
         "review week",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
   },
   sectionFooter = string.format(
      "%s\n%s",
      "total: ",
      "result: "
   ),
   header = string.format(
      "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",
      "@document.meta",
      "stats: [",
      "    resting     : 0",
      "    work        : 0",
      "    uni         : 0",
      "    health      : 0",
      "    social      : 0",
      "    relationship: 0",
      "    projects    : 0",
      "    finances    : 0",
      "]",
      "@end"
   )
}
