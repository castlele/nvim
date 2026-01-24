--- Returns the last element in the string after symbol
---@param str string
---@param sep string
---@return string
local function lastAfter(str, sep)
   local components = vim.split(str, sep, { plain = true })

   return components[#components]
end

---@param str string
---@param target string
---@param dest string
---@return string
local function replaceEvery(str, target, dest)
   local components = vim.split(str, target, { plain = true })

   return table.concat(components, dest)
end

return {
   lastAfter = lastAfter,
   replaceEvery = replaceEvery,
}
