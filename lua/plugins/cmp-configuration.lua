---@class CMPModule
local M = {}

---@param cmp table
---@param keymaps table?
---@return table<string, fun()>
local function parseKeymaps(cmp, keymaps)
   if not keymaps then
      return {}
   end

   local res = {}

   for mode, combs in pairs(keymaps) do
      assert(type(mode) == "string")
      assert(type(combs) == "table")

      for key, fun in pairs(combs) do
         assert(type(key) == "string")
         assert(type(fun) == "function")

          res[key] = cmp.mapping(fun(cmp), { mode })
      end
   end

   return res
end

---@class CMPModuleConfig
---@field keymaps table?
---@param config CMPModuleConfig
function M.setup(config)
   local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
   )

   local luasnip = require("luasnip")

   require("luasnip.loaders.from_vscode").lazy_load()
   luasnip.config.setup()

   vim.lsp.config("*", {
      capabilities = capabilities,
   })

   local cmp = require("cmp")
   -- This is needed for keymap function to understand what completion engine is used
   cmp.type = "cmp"

   cmp.setup {
      experimental = {
         ghost_text = true,
      },
      snippet = {
         expand = function(args)
            luasnip.lsp_expand(args.body)
         end,
      },
      mapping = cmp.mapping.preset.insert(parseKeymaps(cmp, config.keymaps)),
      sources = cmp.config.sources {
         { name = "luasnip" },
         { name = "nvim_lsp" },
         { name = "buffer" },
         { name = "path" },
      },
   }
end

return M
