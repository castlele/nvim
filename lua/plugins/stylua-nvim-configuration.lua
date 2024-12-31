local plugin = require("stylua-nvim")

plugin.setup {
   config_file = "$HOME/.config/nvim/stylua.toml",
}

vim.api.nvim_create_user_command("LuaFormat", plugin.format_file, {})
