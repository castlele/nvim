return {
  name = "swift test",
  builder = function(_)
    return {
      cmd = { "swift" },
      args = { "test" },
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
