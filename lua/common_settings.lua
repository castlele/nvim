vim.g.mapleader = ','
vim.g.neovide_input_macos_alt_is_meta = true

local settings = {
   number = true,
   cursorline = true,
   relativenumber = true,
   ignorecase = true,     -- ignore case
   smartcase = true,      -- but don't ignore it, when search string contains upper letters
   incsearch = true,
   visualbell = true,
   expandtab = true,
   ruler = true,
   smartindent = true,
   hlsearch = true,
   autoindent = true,
   swapfile = false,
   virtualedit = "all",
   backspace = { "indent", "eol", "start" }, -- allow backspacing over everything in insert mode
   mouse = "a",                              -- mouse support
   listchars = { tab = "->", extends = ">", precedes = "<", space = "•"},
   list = true,
   backup = false,
   writebackup = false,
   signcolumn = "yes",
   tabstop = 4,
   shiftwidth = 4,
}

for k, v in pairs(settings) do
   vim.opt[k] = v
end
