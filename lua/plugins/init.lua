---@class PluginsModule
local M = {}

---@class PluginsModuleConfig
---@field isNewLspConfig boolean?
---@field kbasePath string?
---@field weekOpts WeekConfiguration?
---@param config PluginsModuleConfig
function M.setup(config)
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
   require("plugins.luasnip")
   require("plugins.comment")
   require("plugins.oil_configuration")
   require("plugins.treesj-configuration")
   require("plugins.toggleterm-configuration")
   require("plugins.align-configuration")
   require("plugins.stylua-nvim-configuration")
   require("plugins.gitsigns-configuration")
   require("lazydev").setup {
      library = { path = "${3rd}/luv/library", words = { "vim%.uv" } }
   }
   require("build").setup()
   require("mini.map").setup()

   local picker = require("castlelecs.emoji-picker")
   picker.setup {
      keymaps = {
         n = {
            ["<leader>E"] = picker.searchBuildWithTelescope,
         },
      },
   }

   if config.isNewLspConfig ~= nil and config.isNewLspConfig then
      require("plugins.new-lsp-configuration")
   else
      require("plugins.lsp-configuration")
   end

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
               ["<leader>fkb"] = function() telescopeMethods.searchOverKBase(config.kbasePath) end,
            }
         }
      }

      require("castlelecs.obsidian").setup {
         vaults = {
            config.kbasePath,
         },
      }
   end
end

return M
