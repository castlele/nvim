vim.pack.add {
   "https://github.com/wojciech-kulik/xcodebuild.nvim.git",
   "https://github.com/nvim-telescope/telescope.nvim.git",
   "https://github.com/MunifTanjim/nui.nvim.git",
}

local enabled = require("utils.os").isDarwin()

if enabled then
   require("xcodebuild")
end
