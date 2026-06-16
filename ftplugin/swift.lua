vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,
  callback = function(args)
    vim.lsp.buf.format { bufnr = args.buf, timeouts_ms = 1000 }
  end,
})
