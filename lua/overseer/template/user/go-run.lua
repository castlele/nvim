return {
   name = "go run",
   builder = function(params)
      return {
         cmd = { "go" },
         args = vim.list_extend({ "run", "." }, params.args or {}),
         components = { "default" },
      }
   end,
   condition = {
      filetype = { "go" },
   },
}
