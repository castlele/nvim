return {
   "iamcco/markdown-preview.nvim",
   cmd = {
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
   },
   build = "cd app && yarn install",
   init = function()
      vim.g.mkdp_filetypes = { "markdown" }
   end,
   ft = { "markdown" },
   config = function()
      vim.g.mkdp_open_to_the_world = 1

      local l = "<leader>"
      local prefix = ":MarkdownPreview"
      local k = require('utils').keymap

      k("n", l .. "mp", prefix .. "<CR>")
      k("n", l .. "mps", prefix .. "Stop<CR>")
   end,
}
