vim.g.mapleader = ','

vim.cmd("syntax on")

local settings = {
    number = true,
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

    tabstop = 4,
    shiftwidth = 4,
    virtualedit = "all",
    backspace = { "indent", "eol", "start" }, -- allow backspacing over everything in insert mode
    mouse = "a",                              -- mouse support
}

for k, v in pairs(settings) do
    vim.opt[k] = v
end
