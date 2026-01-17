vim.opt_local.tabstop = 3
vim.opt_local.shiftwidth = 3

vim.api.nvim_create_autocmd("BufWritePre", {
   buffer = 0,
   callback = function(args)
      vim.lsp.buf.format { bufnr = args.buf, timeouts_ms = 1000 }
   end,
})

vim.api.nvim_create_autocmd("LspDetach", {
   buffer = 0,
   callback = function(args)
      vim.api.nvim_clear_autocmds {
         event = "BufWritePre",
         buffer = args.buf,
      }
   end,
})

