vim.cmd("syntax on")
local hsb = require("utils").hsbToHex

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

colors.base0 = hsb(223, 0, 87) -- starting from linght gray
colors.base1 = hsb(223, 24, 70)
colors.base2 = hsb(223, 24, 45)
colors.base3 = hsb(223, 25, 20) -- common bg of mine
colors.base4 = hsb(223, 25, 17)
colors.base5 = hsb(223, 0, 8) -- finishing almoust black

--- pink
colors.accent0 = hsb(315, 27, 96)
--- green (mint)
colors.accent1 = hsb(132, 27, 96)
--- yellow
colors.accent2 = hsb(61, 27, 96)
--- purple
colors.accent3 = hsb(253, 27, 96)
--- pale red
colors.accent4 = hsb(359, 27, 96)

--- blue
colors.diagnostics0 = hsb(202, 67, 95)
--- orange
colors.diagnostics1 = hsb(37, 67, 95)
--- red
colors.diagnostics2 = hsb(359, 67, 95)

local colorScheme = {
   --- default background
   Normal = { bg = colors.base3, fg = colors.base0 },
   --- current line number
   CursorLineNr = { fg = colors.accent2, bold = true },
   --- other line numbers
   LineNr = { fg = colors.base2 },
   -- Whitespace = { fg = colors.grey },
   --- float windows
   NormalFloat = { bg = colors.base3, fg = colors.base0 },
   String = { fg = colors.accent2 },

   --- keywords' base object
   Statement = { fg = colors.accent0 },
   -- TODO: Fix
   Comment = { fg = colors.greenpaledark, italic = true },

   Function = { fg = colors.accent1 },
   ["@lsp.type.method"] = { fg = colors.accent1, bold = true },
   ["@function.builtin"] = { fg = colors.accent1 },
   ["@property"] = { fg = colors.base0 },
   ["@lsp.type.variable"] = { fg = colors.base0 },
   ["@lsp.type.property"] = { fg = colors.base0, bold = true },

   Special = { fg = colors.base0 },
   ["@punctuation"] = { fg = colors.base0 },
   ["@punctuation.special"] = { fg = colors.base0 },

   ["@variable.builtin"] = { fg = colors.accent2 },
   ["@variable.parameter.builtin"] = { fg = colors.accent2 },
   ["@constant.builtin"] = { fg = colors.accent2 },
   ["@module.builtin"] = { fg = colors.accent2 },
   ["@type.builtin"] = { fg = colors.accent2 },

   ["@lsp.type.class"] = { fg = colors.accent3, bold = true },
   ["@lsp.type.enum"] = { fg = colors.accent3, bold = true },
   ["@lsp.type.interface"] = { fg = colors.accent3, bold = true },
   ["@lsp.type.namespace"] = { fg = colors.accent3, bold = true },
   ["@lsp.type.struct"] = { fg = colors.accent3, bold = true },

   PreProc = { fg = colors.accent0, bold = true },
   Tag = { fg = colors.accent0, bold = true },

   Type = { fg = colors.accent3, },

   Error = { fg = colors.diagnostics2, },
   ErrorMsg = { fg = colors.diagnostics2, },
   DiagnosticError = { fg = colors.diagnostics2 },

   DiagnosticHint = { fg = colors.diagnostics0 },

   WarningMsg = { fg = colors.diagnostics1 },
   DiagnosticWarn = { fg = colors.diagnostics1 },

   SpellBad = { sp = colors.diagnostics2, undercurl = true, },

   TabLineFill = { bg = colors.base3 },
   TabLine = { bg = colors.base5, fg = colors.base0, bold = false },
   TabLineSolid = { bg = colors.base3, fg = colors.base5, },
   TabLineSelSolid = { bg = colors.base3, fg = colors.accent0 },
   TabLineSel = { bg = colors.accent0, fg = colors.base5, bold = true },

   StatusLine = { bg = colors.base4 },
   StatusLineNormal = { bg = colors.accent0, fg = colors.base5 },
   StatusLineNormalRev = { fg = colors.accent0, bg = colors.base4 },
   StatusLineVisual = { bg = colors.accent3, fg = colors.base5 },
   StatusLineVisualRev = { fg = colors.accent3, bg = colors.base4 },
   StatusLineInsert = { bg = colors.accent2, fg = colors.base5 },
   StatusLineInsertRev = { fg = colors.accent2, bg = colors.base4 },
   StatusLineReplace = { bg = colors.accent4, fg = colors.base5 },
   StatusLineReplaceRev = { fg = colors.accent4, bg = colors.base4 },
   StatusLineCommand = { bg = colors.accent0, fg = colors.base5 },
   StatusLineCommandRev = { fg = colors.accent0, bg = colors.base4 },
   StatusLineTerminal = { bg = colors.accent0, fg = colors.base5 },
   StatusLineTerminalRev = { fg = colors.accent0, bg = colors.base4 },
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

vim.api.nvim_create_autocmd({
   "TextChanged",
   "TextChangedI",
   "BufWritePost",
   "BufReadPost",
   "BufEnter",
   "TabEnter",
   "TabLeave",
   "TabClosed",
}, {
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
         vim.opt_local.statusline = "%#StatusLine# %f%=%l:%c "
      end
   })
end

setup_dynamic_statusline()
