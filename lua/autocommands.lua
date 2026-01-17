local function toggle_relative_numbers(relative)
   vim.opt.relativenumber = relative
   vim.opt.cursorline = relative
end

local function enable_relative_numbers()
   toggle_relative_numbers(true)
end

local function disable_relative_numbers()
   toggle_relative_numbers(false)
end

local function setTerminalKeymaps()
   vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
end

vim.api.nvim_create_autocmd(
   { "InsertEnter" },
   { callback = disable_relative_numbers }
)
vim.api.nvim_create_autocmd(
   { "InsertLeave" },
   { callback = enable_relative_numbers }
)
vim.api.nvim_create_autocmd({ "TermOpen" }, { callback = setTerminalKeymaps })
