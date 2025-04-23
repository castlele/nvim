local ts_languages = {
   "go",
   "c",
   "cpp",
   "lua",
   "python",
   "vimdoc",
   "vim",
   "norg",
   "kotlin",
   "java",
}

local lsp_servers = {
   "gopls",
   "lua_ls",
   "jdtls",
}

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
   ensure_installed = lsp_servers,
}

require("nvim-treesitter.configs").setup {
   ensure_installed = ts_languages,
   auto_install = true,
   highlight = { enable = true },
   indent = { enable = true },
}

vim.lsp.enable(lsp_servers)

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      local opts = { buffer = args.buf, silent = true }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

      -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

      -- if client:supports_method("textDocument/completion") then
      --    vim.lsp.completion.enable(
      --       true,
      --       client.id,
      --       args.buf,
      --       { autotrigger = true }
      --    )
      -- end
   end,
})

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config {
   virtual_lines = { current_line = true },
}

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.config("*", {
   capabilities = capabilities,
})

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
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { "i", "s" }),
   },
   sources = cmp.config.sources {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
   },
}
