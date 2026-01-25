---@return boolean
local function isDarwin()
   return vim.uv.os_uname().sysname == "Darwin"
end

return {
   isDarwin = isDarwin,
}
