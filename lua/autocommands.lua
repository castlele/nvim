function toggle_relative_numbers(relative)
    vim.opt.relativenumber = relative
    vim.opt.cursorline = relative
end

function enable_relative_numbers()
    toggle_relative_numbers(true)
end

function disable_relative_numbers()
    toggle_relative_numbers(false)
end

vim.api.nvim_create_autocmd({ "InsertEnter" }, { callback = disable_relative_numbers })
vim.api.nvim_create_autocmd({ "InsertLeave" }, { callback = enable_relative_numbers })
