return {
   name = "go test",
   builder = function()
      return {
         cmd = { "go" },
         args = { "test", "./...", "-v" },
         components = { "default" },
      }
   end,
   condition = {
      filetype = { "go" },
   },
}
