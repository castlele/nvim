return {
  name = "swift run",
  builder = function(_)
    return {
      cmd = { "swift" },
      args = { "run" },
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "swift" },
    dir = {
      "/home/castlelecs/dev/projects/swiftsetuper",
    },
  },
}
