return {
  name = "swift build",
  builder = function(_)
    return {
      cmd = { "swift" },
      args = { "build" },
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
