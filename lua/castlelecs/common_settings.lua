vim.g.mapleader = ','

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
    tabstop = 4,
    shiftwidth = 4,
    virtualedit = "all",
    backspace = { "indent", "eol", "start" }, -- allow backspacing over everything in insert mode
    mouse = "a",                              -- mouse support
    listchars = { tab = "->", extends = ">", precedes = "<", space = "•"},
    list = true,
    -- Coc recomended settings
    backup = false,
    writebackup = false,
    -- updatetime = 300,
    signcolumn = "yes",
}

for k, v in pairs(settings) do
    vim.opt[k] = v
end
