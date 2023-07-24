local l = "<leader>"
local pref = "g"
local c = ":G"
local post = "<CR>"
local k = require("utils").keymap

-- git status
k("n", l .. pref, c .. post)
-- log (git log)
k("n", l .. pref .. "l", c .. " log" .. post)
-- diff (git diff)
k("n", l .. pref .. "d", c .. " diff" .. post)
--git diff tool (show list of changes)
k("n", l .. pref .. "lc", c .. " difftool" .. post)
--git diff split horizontally
k("n", l .. pref .. "sc" , c .. "diffsplit" .. post)
