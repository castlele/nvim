require("cluautils.table_utils")

---@TODO: Refactor this file!!!!

---@MARK - tree sitter

require('nvim-treesitter.configs').setup {
   ensure_installed = { "swift", 'c', 'cpp', 'lua', 'python', 'vimdoc', 'vim', 'norg', 'kotlin', 'java', 'gleam' },
   auto_install     = true,
   highlight        = { enable = true },
   indent           = { enable = true },
}

---@MARK: - LSP

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason").setup()
-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

local packages = {
   "~/.luaver/luarocks/2.3.0_5.1/share/lua/5.1",
   "${3rd}/love2d/library",
}

local servers = {
   clangd = {},
   pyright = {},
   kotlin_language_server = {},
   lua_ls = {
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
            library = table.concat_tables(vim.api.nvim_get_runtime_file("", true), packages),
            checkThirdParty = false,
            telemetry = { enable = false },
         },
         completion = { callSnippet = "Replace" },
         diagnostics = { globals = { "vim" } },
      }
   },
}

mason_lspconfig.setup {
   ensure_installed = vim.tbl_keys(servers),
}

require("lspconfig").gleam.setup {}

---@MARK - General configuration

local on_attach = function(_, bufnr)
   vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

   local opts = { buffer = bufnr, silent = true }

   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
   vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
   vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
   vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
   vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
   vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
end

mason_lspconfig.setup_handlers {
   function(server_name)
      require('lspconfig')[server_name].setup {
         capabilities = capabilities,
         on_attach = on_attach,
         settings = servers[server_name],
         filetypes = (servers[server_name] or {}).filetypes,
      }
   end
}

--TODO: Move to servser!
require('lspconfig').sourcekit.setup {
   capabilities = capabilities,
   on_attach = on_attach,
}

-- Completion

local cmp = require('cmp')
local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup()

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
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<S-Tab>'] = cmp.mapping.complete(),
   },
   sources = cmp.config.sources(
      {
         -- TODO: Add this as a source on some key combination
         -- TODO: By it self it feels laggy and couses some errors
         -- { name = "codeium" },
         { name = "luasnip" },
         { name = "nvim_lsp" },
         { name = 'buffer' },
         { name = 'path' },
      }
   ),
}
