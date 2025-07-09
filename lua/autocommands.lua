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

local function changeIndentLevel(filetype)
   local tabstop = 4
   local shiftwidth = 4

   if filetype == "lua" then
      tabstop = 3
      shiftwidth = 3
   end

   vim.opt.tabstop = tabstop
   vim.opt.shiftwidth = shiftwidth
end

local function setFileTypeSpecificKeymaps(filetype)
   if filetype == "norg" then
      vim.keymap.set("n", "<space>r", "<cmd>Neorg toggle-concealer<CR>")
   end
end

---@param filetype string
local function setSpell(filetype)
   --TODO: Make it setup'able
   local filetypesToCheck = {
      "html",
      "markdown",
      "norg",
   }

   if vim.tbl_contains(filetypesToCheck, filetype) then
      vim.cmd("set spell spelllang=en,ru")
   else
      vim.cmd("set nospell")
   end
end

local function setupFileTypeSpecific()
   local filetype = vim.bo.filetype

   changeIndentLevel(filetype)
   setFileTypeSpecificKeymaps(filetype)
   setSpell(filetype)
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
vim.api.nvim_create_autocmd({ "FileType" }, { callback = setupFileTypeSpecific })
vim.api.nvim_create_autocmd({ "TermOpen" }, { callback = setTerminalKeymaps })
