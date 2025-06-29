local ts_languages = {
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
}
local cmp_lsp = require('cmp_nvim_lsp')
local capabilities = vim.tbl_deep_extend(
   "force",
   {},
   vim.lsp.protocol.make_client_capabilities(),
   cmp_lsp.default_capabilities())

require("mason").setup()
require("mason-lspconfig").setup {
   ensure_installed = {
      "lua_ls",
      "clangd",
      "gopls",
      "html",
      "jdtls",
      "kotlin_language_server",
   },
}

vim.lsp.enable("sourcekit")

local packages = {
   "~/.luaver/luarocks/2.3.0_5.1/share/lua/5.1",
   "~/.luaver/luarocks/3.0.0_5.1/share/lua/5.1",
   "${3rd}/love2d/library",
}

vim.lsp.config("lua_ls", {
   settings = {
      Lua = {
         runtime = {
            version = "LuaJIT",
            path = {
               "?.lua",
               "?/init.lua",
            },
         },
         format = {
            enable = true,
            defaultConfig = {
               indent_style = "space",
               indent_size = "3",
            },
         },
         workspace = {
            library = packages,
            checkThirdParty = false,
            telemetry = { enable = false },
         },
         completion = { callSnippet = "Replace" },
         diagnostics = { globals = { "vim" } },
      },
   },
})

---@diagnostic disable-next-line
require("nvim-treesitter.configs").setup {
   ensure_installed = ts_languages,
   auto_install = true,
   highlight = { enable = true },
   indent = { enable = true },
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
   local opts = { buffer = event.buf, silent = true }

   vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
   vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
   vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
   vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
   vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
   vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
   vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
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

local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup()

vim.lsp.config("*", {
   capabilities = capabilities,
})

local cmp = require("cmp")
cmp.setup {
   experimental = {
      ghost_text = true,
   },
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert {
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm { select = true },
   },
   sources = cmp.config.sources {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
   },
}
