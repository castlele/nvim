---@class CommandOpts
---@field args table<string>?

---@class Git
---@field private cmdQueue table<table<string>>
local M = {
   cmdQueue = {},
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
   M._drain()
end

---@param opts CommandOpts?
---@return Git
function M.stashAll(opts)
   M._enqueueCmd({ "git", "stash", "push" }, opts)
   return M
end

---@param opts CommandOpts?
---@return Git
function M.pull(opts)
   M._enqueueCmd({ "git", "pull" }, opts)
   return M
end

---@return Git
function M.autoPull()
   return M.stashAll()
      .pull({
         args = {
            "--no-edit",
         },
      })
      .applyTopStash()
end

---@param opts CommandOpts?
---@return Git
function M.applyTopStash(opts)
   M._enqueueCmd({ "git", "stash", "pop", "stash@{0}" }, opts)
   return M
end

---@param path table|string
---@param opts CommandOpts?
---@return Git
function M.add(path, opts)
   if type(path) == "string" then
      M._enqueueCmd({ "git", "add", path }, opts)
   else
      M._enqueueCmd(mergeTables({ "git", "add" }, path), opts)
   end

   return M
end

---@param opts CommandOpts?
---@return Git
function M.amendCommit(opts)
   M._enqueueCmd({ "git", "commit", "--amend" }, opts)
   return M
end

---@param opts CommandOpts?
---@return Git
function M.push(opts)
   M._enqueueCmd({ "git", "push" }, opts)
   return M
end

---TODO: Update for functional style, returning Git with boolean
---@async
---@return boolean
function M.hasAnythingToPull()
   local hasChanges = function(resume)
      vim.system(
         { "git", "rev-list", "--count", "HEAD..@{u}" },
         { text = true },
         function(res)
            if res.code ~= 0 then
               resume(false)
               return
            end

            local count = tonumber(res.stdout)
            resume(count ~= nil and count > 0)
         end
      )
   end

   return require("async").await(hasChanges)
end

---@private
---@param cmd table<string>
---@param opts CommandOpts?
function M._enqueueCmd(cmd, opts)
   opts = opts or {}
   local fullCmd = mergeTables(cmd, (opts.args or {}))

   table.insert(M.cmdQueue, fullCmd)
end

---@async
---@private
function M._drain()
   local cmd = table.remove(M.cmdQueue, 1)

   if not cmd then
      vim.schedule(function()
         vim.notify("Git is finished to execute commands", vim.log.levels.INFO)
      end)

      return
   end

   vim.schedule(function()
      vim.notify(
         "Git command is running: " .. table.concat(cmd, " "),
         vim.log.levels.INFO
      )
   end)

   local execute = function(resume)
      vim.system(cmd, {}, function(res)
         resume(res.code)
      end)
   end

   local code = require("async").await(execute)

   if code ~= 0 then
      vim.schedule(function()
         vim.notify(
            "Git failed: " .. table.concat(cmd, " "),
            vim.log.levels.ERROR
         )
      end)
   end

   M._drain()
end

return M
