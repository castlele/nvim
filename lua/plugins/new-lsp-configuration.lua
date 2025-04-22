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
   "gopls", -- go: go install golang.org/x/tools/gopls@latest
   "lua_ls"
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

local on_attach = function(bufnr)
   vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

   local opts = { buffer = bufnr, silent = true }

   vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
   vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
   vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
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
end

vim.api.nvim_create_autocmd('LspAttach', {
   callback = function(ev)
      on_attach(ev.buf)
      local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

      if client:supports_method('textDocument/completion') then
         vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
   end,
})
vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
   virtual_text = true,
  -- virtual_text = { current_line = true }
})
