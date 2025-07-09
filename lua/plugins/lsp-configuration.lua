---@class LspModule
local M = {}

---@class LspModuleConfig
---@field keymaps table?
---@field lsps table<string>?
---@param config LspModuleConfig
function M.setup(config)
   require("mason-lspconfig").setup {
      ensure_installed = config.lsps or {},
   }

   require("plugins.languages.lsp-setup")

   vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
         local opts = { buffer = event.buf, silent = true }

         if config.keymaps then
            require("utils").setKeymaps(config.keymaps)
         end

         -- TODO: Research msason formatters
         vim.keymap.set("n", "<space>f", function()
            if vim.bo.filetype == "lua" then
               vim.cmd("LuaFormat")
            else
               vim.lsp.buf.format { async = true }
            end
         end, opts)
      end,
   })

   vim.cmd("set completeopt+=noselect")
   vim.diagnostic.config {
      virtual_lines = { current_line = true },
   }
end

return M
