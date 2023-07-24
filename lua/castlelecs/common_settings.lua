vim.g.mapleader = ','

vim.cmd("syntax on")
vim.cmd("set termguicolors")
vim.cmd("hi Cursor guifg=yellow guibg=yellow")
vim.cmd("hi Cursor2 guifg=white guibg=white")

local settings = {
    number = true,
    guicursor = "n:block-Cursor2/lCursor2,v-c-i:block-Cursor/lCursor",
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

    -- Coc recomended settings
    backup = false,
    writebackup = false,
    updatetime = 300,
    signcolumn = "yes"
}

for k, v in pairs(settings) do
    vim.opt[k] = v
end
