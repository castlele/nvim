---@class PluginsModule
local M = {}

---@class PluginsModuleConfig
---@field kbasePath string?
---@field notesPath string?
---@field weekOpts WeekConfiguration?
---@param config PluginsModuleConfig
function M.setup(config)
   require("autocommands")
   require("appearance")
   require("plenary")
   require("castlelecs.common_settings")
   require("castlelecs.case_converter_binding")
   require("castlelecs.imports_sorting")
   require("plugins.markdown_preview")
   require("plugins.better_whitespace")
   require("plugins.lualine")
   require("plugins.comment")
   --TODO: Uncomment or remove plugin after testing of the default vim's FM
   --require("plugins.oil_configuration")
   require("plugins.treesj-configuration")
   require("plugins.toggleterm-configuration")
   require("plugins.align-configuration")
   require("plugins.stylua-nvim-configuration")
   require("plugins.gitsigns-configuration")
   require("lazydev").setup {
      library = {
         path = "${3rd}/luv/library",
         words = {
            "vim%.uv",
         },
      },
   }
   require("build").setup()
   require("mini.map").setup()
   local customKeymaps = {
      n = {
         ["<leader>nh"] = vim.cmd.noh,
         ["th"] = vim.cmd.tabprev,
         ["tl"] = vim.cmd.tabnext,
         ["tn"] = vim.cmd.tabnew,
      },
   }
   require("utils").setKeymaps(customKeymaps)
   require("utils").keymap("n", "y", '"+y')
   require("utils").keymap("v", "y", '"+y')

   local picker = require("castlelecs.emoji-picker")
   picker.setup {
      keymaps = {
         n = {
            ["<leader>E"] = picker.searchBuildWithTelescope,
         },
      },
   }
   local editorActions = require("castlelecs.editor-actions")

   require("plugins.luasnip").setup {
      keymaps = {
         i = {
            ["<C-j>"] = editorActions.moveNextArg,
            ["<C-k>"] = editorActions.movePrevArg,
         },
         s = {
            ["<C-j>"] = editorActions.moveNextArg,
            ["<C-k>"] = editorActions.movePrevArg,
         },
      },
   }
   require("plugins.lsp-configuration").setup {
      lsps = {
         "lua_ls",
         "clangd",
         "gopls",
         "html",
         "jdtls",
         "kotlin_language_server",
         "marksman",
      },
      keymaps = {
         n = {
            ["gD"] = editorActions.goToDeclaration,
            ["gd"] = editorActions.goToDefinition,
            ["gr"] = editorActions.goToReferences,
            ["K"] = editorActions.showHelp,
            ["<C-K>"] = editorActions.showCodeActions,
            ["<leader>rn"] = editorActions.rename,
            ["<leader>e"] = editorActions.showDiagnostics,
         },
         i = {
            ["<C-S>"] = editorActions.showSignatureHelp,
         },
      },
   }

   require("plugins.treesitter-configuration").setup {
      languages = {
         "go",
         "c",
         "cpp",
         "lua",
         "vimdoc",
         "vim",
         "norg",
         "kotlin",
         "java",
         "swift",
         "objc",
      },
   }

   require("plugins.cmp-configuration").setup {
      keymaps = {
         i = {
            ["<C-Space>"] = editorActions.activateCompletions,
         },
      },
   }

   if config.weekOpts then
      require("castlelecs.norgtemplate").setup(config.weekOpts)
   end

   if config.kbasePath then
      local telescopeMethods = require("plugins.telescope-methods")
      require("plugins.telescope").setup {
         setup = telescopeMethods.setupTelescope,
         loadExtensions = telescopeMethods.loadExtensions,
         telescopeBufferKeymaps = {
            i = {
               ["<C-w>"] = telescopeMethods.openSelectedInQlistAction(),
               ["<C-y>"] = telescopeMethods.togglePreviewAction(),
            },
         },
         keymaps = {
            n = {
               ["<space>fc"] = telescopeMethods.searchFileComponents,
               ["<leader>O"] = telescopeMethods.findFilesOverProject,
               ["<leader>F"] = telescopeMethods.live_grep,
               ["<leader>f"] = telescopeMethods.searchOverCurrentFile,
               ["<leader>ms"] = telescopeMethods.multiSearch,
               ["<leader>fkb"] = function()
                  telescopeMethods.searchOverKBase(config.kbasePath)
               end,
            },
         },
      }

      require("castlelecs.obsidian").setup {
         vaults = {
            {
               path = config.kbasePath,
               res = "res",
               templates = "templates",
            },
         },
      }

      local notesModule = require("castlelecs.notes")
      notesModule.setup {
         notesPath = config.notesPath,
         keymaps = {
            n = {
               ["<leader>n"] = notesModule.openLastNote,
            },
         },
      }
   end
end

return M
