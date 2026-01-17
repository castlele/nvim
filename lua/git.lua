---@class CommandOpts
---@field args table<string>?

---@class Git
---@field private cmdQueue table<table<string>>
---@field private isRunning boolean
local M = {
   cmdQueue = {},
   isRunning = false,
}

---@param t1 table
---@param t2 table
---@return table
local function mergeTables(t1, t2)
   local res = vim.deepcopy(t1)

   for _, value in ipairs(t2) do
      table.insert(res, value)
   end

   return res
end

function M.execute()
   M.drain()
end

---@private
function M.drain()
   if M.isRunning then
      return
   end

   local cmd = table.remove(M.cmdQueue, 1)

   if not cmd then
      M.isRunning = false

      vim.schedule(function()
         vim.notify("Git is finished to execute commands", vim.log.levels.INFO)
      end)

      return
   end

   M.isRunning = true

   vim.schedule(function()
      vim.notify(
         "Git command is running: " .. table.concat(cmd, " "),
         vim.log.levels.INFO
      )
   end)

   vim.fn.jobstart(cmd, {
      on_exit = function(_, code, _)
         if code ~= 0 then
            vim.schedule(function()
               vim.notify(
                  "Git failed: " .. table.concat(cmd, " "),
                  vim.log.levels.ERROR
               )
            end)
         end
         M.isRunning = false
         M.drain()
      end,
   })
end

---@param opts CommandOpts?
---@return Git
function M.stashAll(opts)
   M.enqueueCmd({ "git", "stash", "push" }, opts)
   return M
end

---@param opts CommandOpts?
---@return Git
function M.pull(opts)
   M.enqueueCmd({ "git", "pull" }, opts)
   return M
end

---@param opts CommandOpts?
---@return Git
function M.applyTopStash(opts)
   M.enqueueCmd({ "git", "stash", "pop", "stash@{0}" }, opts)
   return M
end

---@param path table|string
---@param opts CommandOpts?
---@return Git
function M.add(path, opts)
   if type(path) == "string" then
      M.enqueueCmd({ "git", "add", path }, opts)
   else
      M.enqueueCmd(mergeTables({ "git", "add" }, path), opts)
   end

   return M
end

---@param opts CommandOpts?
---@return Git
function M.amendCommit(opts)
   M.enqueueCmd({ "git", "commit", "--amend" }, opts)
   return M
end

---@param opts CommandOpts?
---@return Git
function M.push(opts)
   M.enqueueCmd({ "git", "push" }, opts)
   return M
end

---@private
---@param cmd table<string>
---@param opts CommandOpts?
function M.enqueueCmd(cmd, opts)
   opts = opts or {}
   local fullCmd = mergeTables(cmd, (opts.args or {}))

   table.insert(M.cmdQueue, fullCmd)
end

return M
