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

local function change_indent_level()
   local filetype = vim.bo.filetype
   local tabstop = 4
   local shiftwidth = 4

   if filetype == "lua" then
      tabstop = 3
      shiftwidth = 3
   end

   vim.opt.tabstop = tabstop
   vim.opt.shiftwidth = shiftwidth
end

vim.api.nvim_create_autocmd({ "InsertEnter" }, { callback=disable_relative_numbers })
vim.api.nvim_create_autocmd({ "InsertLeave" }, { callback=enable_relative_numbers })
vim.api.nvim_create_autocmd({ "FileType" }, { callback=change_indent_level })
