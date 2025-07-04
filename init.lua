local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
   vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
   }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
   vim.tbl_values(require("lazyplugins")),
}

local localConf = require("local")

require("plugins").setup {
   kbasePath = localConf.kbasePath,
   notesPath = localConf.notesPath,
   weekOpts = require("weekOpts"),
}
