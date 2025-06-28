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

   -- Git
   { "lewis6991/gitsigns.nvim" },

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

local dailyTasks = {
   "do sport",
   "meditate",
   "read book",
   "reflex on thoughs",
}
---@type WeekConfiguration
local weekOpts = {
   week = {
      MON = {
         "work - 3h",
         "fill stats",
         "prepare next week file",
         "take care of Javie",
         daily = dailyTasks,
      },
      TUE = {
         "work - 3h",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      WED = {
         ["work - 3h"] = {
            "design demo",
         },
         "clean the floors",
         "clean the office",
         daily = dailyTasks,
      },
      THU = {
         "work - 3h",
         daily = dailyTasks,
      },
      FRI = {
         "psychology session %13:00% - 1h",
         "work - 3h",
         "take care of Javie",
         daily = dailyTasks,
      },
      SAT = {
         "followattr - 1h",
         "comeback - 30m",
         "call to grandmother",
         daily = dailyTasks,
      },
      SUN = {
         "followattr - 1h",
         "comeback - 30m",
         "clean the floors",
         "clean the office",
         "review goals",
         "review week",
         daily = dailyTasks,
      },
   },
   sectionFooter = string.format(
      "%s\n%s\n%s",
      "goal: %SMART goal%",
      "total: ",
      "result: "
   ),
   header = string.format(
      "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",
      "@document.meta",
      "goal: %SMART goal%",
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

require("plugins").setup {
   isNewLspConfig = false,
   kbasePath = "$HOME/dev/kbase",
   weekOpts = weekOpts,
}
