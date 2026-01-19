---@class SyncModule
---@field attachments table<string, integer>
local M = {
   attachments = {},
}

---@class SyncItem
---@field path string
---@field data table?
---@field auto_cmd table<string>|string
---@field sync_cmd fun(data: table)

---This function expands ldcards and special keywords like $HOME
---@param path string input path
---@return string absolute path
local function expandPath(path)
   return vim.fn.fnamemodify(vim.fn.expand(path), ":p")
end

---@param cwd string
---@param dir string
---@return boolean
local function isInsideDirectory(cwd, dir)
   cwd = expandPath(cwd)
   dir = expandPath(dir)

   if not cwd or not dir then
      return false
   end

   return cwd:sub(1, #dir) == dir
end

---@param item SyncItem
local function attachSync(item)
   if M.attachments[item.path] then
      return
   end

   local id = vim.api.nvim_create_autocmd(item.auto_cmd, {
      callback = function()
         vim.schedule(function()
            item.sync_cmd(item.data or {})
         end)
      end,
   })

   M.attachments[item.path] = id
end

local function detachSync(item)
   local id = M.attachments[item.path]

   if not id then
      return
   end

   vim.api.nvim_del_autocmd(id)

   M.attachments[item.path] = nil
end

---@param items table<SyncItem>
---@param cwd string
local function tryToAttachSyncItems(items, cwd)
   for _, item in ipairs(items) do
      if isInsideDirectory(cwd, item.path) then
         attachSync(item)
      else
         detachSync(item)
      end
   end
end

---@class SyncConfig
---@field items table<SyncItem>
---@param config SyncConfig
function M.setup(config)
   local cwd = vim.fn.getcwd(0)

   tryToAttachSyncItems(config.items, cwd)

   vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
         cwd = vim.fn.getcwd(0)

         tryToAttachSyncItems(config.items, cwd)
      end,
   })
end

return M
