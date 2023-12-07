vim.cmd("syntax on")

vim.cmd("colorscheme castlelecsscheme")
vim.cmd("set termguicolors")
vim.cmd("hi Cursor guifg=yellow guibg=yellow")
vim.cmd("hi Cursor2 guifg=white guibg=white")
vim.cmd("set colorcolumn=120")
vim.opt.guicursor = "n:block-Cursor2/lCursor2,v-c-i:block-Cursor/lCursor,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.cmd("highlight clear SignColumn") -- Remove gray line in error column
