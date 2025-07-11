vim.cmd("syntax on")

local colors = {
   bglight = "#586074",
   bg = "#272b34",
   bgdark = "#21242c",
   green = "#b3f6c0",
   greendark = "#387a6b",
   white = "#dedede",
   pink = "#ff66b0",
   yellow = "#feffad",
   purple = "#beadfa",
   search = "#adadad",
   blue = "#8cf8f7",
   grey = "#494a50",
   greylight = "#9b9ea4",
}

-- {
--   foreground = 11794112
-- }

local function int_to_hex(color)
    return string.lower(string.format("#%06X", color))
end

vim.api.nvim_create_user_command("ToHex", function(args)
   local color = int_to_hex(args.args)
   vim.fn.setreg("+", color)
   print(color)
end, {nargs = 1})

vim.api.nvim_create_user_command("GetColor", function(args)
   local colors = vim.inspect(vim.api.nvim_get_hl_by_name(args.args, true))
   vim.fn.setreg("+", colors)
   print(colors)
end, {nargs = 1})

local colorScheme = {
   --- default background
   Normal = { bg = colors.bg, fg = colors.white },
   --- current line number
   CursorLineNr = { fg = colors.yellow, bold = true },
   --- other line numbers
   LineNr = { fg = colors.bglight },
   Whitespace = { fg = colors.grey },
   --- float windows
   NormalFloat = { bg = colors.bg, fg = colors.white },
   String = { fg = colors.green },
   ["@string"] = { fg = colors.green },
   --- keywords' base object
   Statement = { fg = colors.pink },
   Comment = { fg = colors.greendark, italic = true },

   --- Parentheses
   Special = { fg = colors.blue },

   PreProc = { fg = colors.purple, bold = true },
   Tag = { fg = colors.purple, bold = true },
}

for type, opts in pairs(colorScheme) do
   vim.api.nvim_set_hl(0, type, opts)
end

vim.cmd("hi Cursor guifg=yellow guibg=yellow")
vim.cmd("hi Cursor2 guifg=white guibg=white")

vim.cmd("set colorcolumn=80")

vim.opt.guicursor = "n:block-Cursor2/lCursor2,v-c-i:block-Cursor/lCursor,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- vim.cmd("highlight clear SignColumn") -- Remove gray line in error column
