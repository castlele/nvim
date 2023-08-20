require("castlelecs.case_converter")

vim.api.nvim_create_user_command("Case", ToggleCase, { desc = "ToSnake", complete = Completion, nargs = 1 })

