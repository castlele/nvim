vim.loader.enable()

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

-- TODO: Add abilityes:
-- 1. evaluate math (like here: https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/operators.lua#L768)
-- 2. can I update default match algorithm for telescope. As stated [here](https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/pick.lua) it is slower than mini.picker itself
-- 3. try [mini.colors](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-colors.md)
require("lazy").setup {
   spec = {
        { import = "plugins" },
    },
    change_detection = {
        enable = false,
        notify = false,
    },
    checker = {
        enabled = true,
        frequency = 7 * 24 * 3600,
    },
}
