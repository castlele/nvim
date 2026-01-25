---@enum DeviceManagerHI
local HI = {
   IosHeader = "IosHeader",
   AndroidHeader = "AndroidHeader",
   RowOS = "RowOS",
   SuspendedRowStatus = "SuspendedRowStatus",
}

---@class DeviceManagerConfig
local M = {
   hi = HI,
}
local namespace = vim.api.nvim_create_namespace("device-manager")

---@return vim.api.keyset.win_config
function M.createMainWindowConfig()
   local width = math.floor(vim.o.columns * 0.8)
   local height = math.floor(vim.o.lines * 0.8)

   local col = math.floor((vim.o.columns - width) / 2)
   local row = math.floor((vim.o.lines - height) / 2)

   return {
      relative = "editor",
      width = width,
      height = height,
      col = col,
      row = row,
      style = "minimal",
      border = "rounded",
   }
end

function M.setHighlighting()
   local id = vim.api.nvim_get_hl_id_by_name("Normal")
   local normal = vim.api.nvim_get_hl(id, {})

   vim.api.nvim_set_hl(0, M.hi.IosHeader, {
      bold = true,
      fg = normal.fg,
      bg = "#5ac8fa",
   })

   vim.api.nvim_set_hl(0, M.hi.AndroidHeader, {
      bold = true,
      fg = normal.fg,
      bg = "#a4c639",
   })

   vim.api.nvim_set_hl(0, M.hi.RowOS, { link = "Comment" })
   vim.api.nvim_set_hl(0, M.hi.SuspendedRowStatus, { link = "Error" })
end

---@param buf integer
---@param row integer
---@param startColumn integer
---@param endColumn integer
---@param group DeviceManagerHI
function M.highlightRange(buf, row, startColumn, endColumn, group)
   vim.api.nvim_buf_set_extmark(buf, namespace, row, startColumn, {
      end_row = row,
      end_col = endColumn,
      hl_group = group,
      priority = 200,
   })
end

return M
