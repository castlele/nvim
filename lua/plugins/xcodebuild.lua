return {
   "wojciech-kulik/xcodebuild.nvim",
   dependencies = {
      -- NOTE: if xcodebuild plugin will be used, try to integrate mini.pick to remove telescope dependency
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
   },
   enabled = require("utils.os").isDarwin(),
   opts = true,
}
