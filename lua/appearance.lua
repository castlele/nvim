vim.cmd("syntax on")

local colors = {
   bglight = "#586074",
   bg = "#272b34",
   bgdark = "#21242c",
   green = "#b3f6c0",
   greenpaledark = "#387a6b",
   white = "#dedede",
   pink = "#ff66b0",
   yellow = "#feffad",
   purple = "#beadfa",
   red = "#ff471a",
   orangelight = "#ffd9b3",
   orange = "#ffa64d",
   search = "#adadad",
   blue = "#8cf8f7",
   grey = "#494a50",
   greylight = "#9b9ea4",
   dark = "#141414",
}

local function int_to_hex(color)
   return string.lower(string.format("#%06X", color))
end

vim.api.nvim_create_user_command("ToHex", function(args)
   local color = int_to_hex(args.args)
   vim.fn.setreg("+", color)
   print(color)
end, { nargs = 1 })

vim.api.nvim_create_user_command("GetColor", function(args)
   local colors = vim.inspect(vim.api.nvim_get_hl_by_name(args.args, true))
   vim.fn.setreg("+", colors)
   print(colors)
end, { nargs = 1 })

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
   String = { fg = colors.orangelight },

   --- keywords' base object
   Statement = { fg = colors.pink },
   Comment = { fg = colors.greenpaledark, italic = true },

   Function = { fg = colors.green },
   ["@lsp.type.method"] = { fg = colors.green, bold = true },
   ["@function.builtin"] = { fg = colors.green },
   ["@property"] = { fg = colors.white },
   ["@lsp.type.variable"] = { fg = colors.white },
   ["@lsp.type.property"] = { fg = colors.yellow, bold = true },

   Special = { fg = colors.blue },
   ["@punctuation"] = { fg = colors.blue },
   ["@punctuation.special"] = { fg = colors.blue },

   ["@variable.builtin"] = { fg = colors.yellow },
   ["@variable.parameter.builtin"] = { fg = colors.yellow },
   ["@constant.builtin"] = { fg = colors.yellow },
   ["@module.builtin"] = { fg = colors.yellow },
   ["@type.builtin"] = { fg = colors.yellow },

   ["@lsp.type.class"] = { fg = colors.white, bold = true },
   ["@lsp.type.enum"] = { fg = colors.white, bold = true },
   ["@lsp.type.interface"] = { fg = colors.white, bold = true },
   ["@lsp.type.namespace"] = { fg = colors.white, bold = true },
   ["@lsp.type.struct"] = { fg = colors.white, bold = true },

   PreProc = { fg = colors.purple, bold = true },
   Tag = { fg = colors.purple, bold = true },

   Type = { fg = colors.yellow, },

   Error = { fg = colors.red, },
   ErrorMsg = { fg = colors.red, },
   DiagnosticError = { fg = colors.red },

   DiagnosticHint = { fg = colors.blue },

   WarningMsg = { fg = colors.orange },
   DiagnosticWarn = { fg = colors.orange },

   SpellBad = { sp = colors.red, undercurl = true, },

   TabLineFill = { bg = colors.bg },
   TabLine = { bg = colors.dark, fg = colors.white, bold = false },
   TabLineSolid = { bg = colors.bg, fg = colors.dark, },
   TabLineSelSolid = { bg = colors.bg, fg = colors.pink },
   TabLineSel = { bg = colors.pink, fg = colors.dark, bold = true },

   StatusLine = { bg = colors.bgdark },
   StatusLineNormal = { bg = colors.pink, fg = colors.dark },
   StatusLineNormalRev = { fg = colors.pink, bg = colors.bgdark },
   StatusLineVisual = { bg = colors.purple, fg = colors.dark },
   StatusLineVisualRev = { fg = colors.purple, bg = colors.bgdark },
   StatusLineInsert = { bg = colors.yellow, fg = colors.dark },
   StatusLineInsertRev = { fg = colors.yellow, bg = colors.bgdark },
   StatusLineReplace = { bg = colors.red, fg = colors.dark },
   StatusLineReplaceRev = { fg = colors.red, bg = colors.bgdark },
   StatusLineCommand = { bg = colors.pink, fg = colors.dark },
   StatusLineCommandRev = { fg = colors.pink, bg = colors.bgdark },
   StatusLineTerminal = { bg = colors.pink, fg = colors.dark },
   StatusLineTerminalRev = { fg = colors.pink, bg = colors.bgdark },
}

for type, opts in pairs(colorScheme) do
   vim.api.nvim_set_hl(0, type, opts)
end

vim.cmd("hi Cursor guifg=yellow guibg=yellow")
vim.cmd("hi Cursor2 guifg=white guibg=white")

vim.cmd("set colorcolumn=80")

vim.opt.guicursor =
"n:block-Cursor2/lCursor2,v-c-i:block-Cursor/lCursor,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

local function createTabline()
   local s = " "

   local currentTab = vim.api.nvim_get_current_tabpage()
   local tabs = vim.api.nvim_list_tabpages()

   for i, id in ipairs(tabs) do
      if currentTab == id then
         s = s .. "%#TabLineSel#"
      else
         s = s .. "%#TabLine#"
      end

      if i == 1 then
         if currentTab == id then
            s = s .. "%#TabLineSelSolid#%#TabLineSel# "
         else
            s = s .. "%#TabLineSolid#%#TabLine# "
         end
      end

      if i > 1 then
         s = s .. " "
      end

      s = s .. tostring(i)

      local wins = vim.api.nvim_tabpage_list_wins(id)

      for _, win in ipairs(wins) do
         local buf = vim.api.nvim_win_get_buf(win)

         local mod = vim.fn.getbufvar(buf, '&mod')

         if mod == 1 then
            s = s .. "[+]"
            break
         end
      end

      s = s .. " "

      if i == #tabs then
         if currentTab == id then
            s = s .. "%#TabLineSelSolid#%#TabLineFill# Look back!"
         else
            s = s .. "%#TabLineSolid#%#TabLineFill# Look back!"
         end
      end
   end

   s = s .. "%=%t "

   return s
end

vim.opt.showtabline = 2
vim.opt.tabline = createTabline()

vim.api.nvim_create_autocmd({ "BufEnter" }, {
   callback = function()
      vim.opt.tabline = createTabline()
   end
})

local modes = {
   n       = { name = "NORMAL", color = "StatusLineNormal" },
   c       = { name = "COMMAND", color = "StatusLineCommand" },
   ["!"]   = { name = "SHELL", color = "StatusLineCommand" },
   t       = { name = "TERMINAL", color = "StatusLineTerminal" },

   i       = { name = "INSERT", color = "StatusLineInsert" },

   v       = { name = "VISUAL", color = "StatusLineVisual" },
   V       = { name = "V-LINE", color = "StatusLineVisual" },
   ["\22"] = { name = "V-BLOCK", color = "StatusLineVisual" },
   s       = { name = "SELECT", color = "StatusLineVisual" },
   S       = { name = "S-LINE", color = "StatusLineVisual" },
   ["\19"] = { name = "S-BLOCK", color = "StatusLineVisual" },

   R       = { name = "REPLACE", color = "StatusLineReplace" },
}

---@return string
local function getModeName()
   local mode = modes[vim.fn.mode()]
   local name = mode.name or ("UNKNOWN [" .. vim.fn.mode() .. "]")
   local color = "%#" .. (mode.color or "StatusLineReplace")
   local revcolor = color .. "Rev#"

   color = color .. "#"

   return string.format(
      "%s%s %s %s",
      revcolor,
      color,
      name,
      revcolor
   ) .. "%#StatusLine#"
end

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufWritePost", "BufReadPost" }, {
   callback = function()
      vim.opt.tabline = createTabline()
   end,
})

local function setup_dynamic_statusline()
   vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "ModeChanged" }, {
      callback = function()
         vim.opt_local.statusline = table.concat {
            getModeName(),
            "%=",
            "%p%%   ",
            "%l:%c ",
         }
      end
   })

   vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
      callback = function()
         vim.opt_local.statusline = " %f%=%l:%c "
      end
   })
end

setup_dynamic_statusline()
