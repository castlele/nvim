local plugin = require("stylua-nvim")

plugin.setup {
   config_file = "stylua.toml"
}

vim.api.nvim_create_user_command("LuaFormat", plugin.format_file, {})
