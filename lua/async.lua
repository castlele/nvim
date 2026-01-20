local M = {}

function M.await(fn)
   return coroutine.yield(function(resume)
      fn(resume)
   end)
end

function M.launch(fn)
   local co = coroutine.create(fn)

   local function step(...)
      local ok, yielded = coroutine.resume(co, ...)

      if not ok or coroutine.status(co) == "dead" then
         return
      end

      yielded(step)
   end

   step()
end

return M
