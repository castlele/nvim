local M = {}

local function get_opts(desc)
   return { noremap = true, silent = true, desc = desc }
end

---@return table<string>, integer, integer
function M.getSelectedLines()
   local from = vim.fn.getpos("'<")[2]
   local to = vim.fn.getpos("'>")[2]

   if from == nil or to == nil then
      return {}, 0, 0
   end

   if to < from then
      from, to = to, from
   end

   local lines = vim.api.nvim_buf_get_lines(0, from - 1, to, false)

   return lines, from, to
end

function M.keymap(mode, lhs, rhs, desc)
   vim.api.nvim_set_keymap(mode, lhs, rhs, get_opts(desc))
end

function M.keymap_func(mode, lhs, rhs, desc)
   vim.keymap.set(mode, lhs, rhs, get_opts(desc))
end

---@param keymaps table
function M.setKeymaps(keymaps)
   for mode, combs in pairs(keymaps) do
      assert(type(mode) == "string")
      assert(type(combs) == "table")

      for key, fun in pairs(combs) do
         assert(type(key) == "string")
         assert(type(fun) == "function")

         M.keymap_func(mode, key, fun)
      end
   end
end

function M.throwError(msg)
   vim.notify(msg, vim.log.levels.ERROR)
end

---@param filter string
---@param variants table[string]
---@return table[string]
function M.completion(filter, variants)
   if not filter or #filter == 0 then
      return variants
   end

   local filteredVariants = {}

   for _, variant in ipairs(variants) do
      local s = string.find(variant, filter)

      if s then
         table.insert(filteredVariants, variant)
      end
   end

   return filteredVariants
end

function M.hslToHex(h, s, l)
    s = s / 100
    l = l / 100

    local c = (1 - math.abs(2 * l - 1)) * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = l - c / 2

    local r, g, b = 0, 0, 0

    if h >= 0 and h < 60 then
        r, g, b = c, x, 0
    elseif h >= 60 and h < 120 then
        r, g, b = x, c, 0
    elseif h >= 120 and h < 180 then
        r, g, b = 0, c, x
    elseif h >= 180 and h < 240 then
        r, g, b = 0, x, c
    elseif h >= 240 and h < 300 then
        r, g, b = x, 0, c
    elseif h >= 300 and h < 360 then
        r, g, b = c, 0, x
    end

    r = math.floor((r + m) * 255 + 0.5)
    g = math.floor((g + m) * 255 + 0.5)
    b = math.floor((b + m) * 255 + 0.5)

    return string.format("#%02x%02x%02x", r, g, b)
end

function M.hsbToHex(h, s, v)
    s = s / 100
    v = v / 100

    local c = v * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = v - c

    local r, g, b = 0, 0, 0

    if h >= 0 and h < 60 then
        r, g, b = c, x, 0
    elseif h >= 60 and h < 120 then
        r, g, b = x, c, 0
    elseif h >= 120 and h < 180 then
        r, g, b = 0, c, x
    elseif h >= 180 and h < 240 then
        r, g, b = 0, x, c
    elseif h >= 240 and h < 300 then
        r, g, b = x, 0, c
    elseif h >= 300 and h < 360 then
        r, g, b = c, 0, x
    end

    r = math.floor((r + m) * 255 + 0.5)
    g = math.floor((g + m) * 255 + 0.5)
    b = math.floor((b + m) * 255 + 0.5)

    return string.format("#%02x%02x%02x", r, g, b)
end

return M
