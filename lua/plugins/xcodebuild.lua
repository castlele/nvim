return {
   "wojciech-kulik/xcodebuild.nvim",
   dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
   },
   enabled = vim.uv.os_uname().sysname == "Darwin",
   opts = true,
}
