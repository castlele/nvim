---@class Window
---@field buf integer
---@field win integer
---@field width integer
---@field height integer

---@param bufn integer?
---@param opts vim.api.keyset.win_config?
---@return Window
local function openFloatingWindow(bufn, opts)
   opts = opts or {}

   opts.width = opts.width or vim.o.columns
   opts.height = opts.height or vim.o.lines
   opts.relative = opts.relative or "editor"

   if not bufn or not vim.api.nvim_buf_is_loaded(bufn) then
      bufn = vim.api.nvim_create_buf(false, true)
   end

   local win = vim.api.nvim_open_win(bufn, true, opts)

   return {
      buf = bufn,
      win = win,
      width = opts.width,
      height = opts.width,
   }
end

return {
   openFloatingWindow = openFloatingWindow,
}
