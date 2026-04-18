local hsb = require("utils").hsbToHex

local colors = {
   greenpaledark = "#387a6b",
}

--- #dedede
colors.base0 = hsb(223, 0, 87) -- starting from linght gray
--- #8894B3
colors.base1 = hsb(223, 24, 70)
--- #575F73
colors.base2 = hsb(223, 24, 45)
--- #262a33
colors.base3 = hsb(223, 25, 20) -- common bg of mine
--- #21242b
colors.base4 = hsb(223, 25, 17)
--- #141414
colors.base5 = hsb(223, 0, 8) -- finishing almoust black

--- pink #f5b3e4
colors.accent0 = hsb(315, 27, 96)
--- green (mint) #b3f5c0
colors.accent1 = hsb(132, 27, 96)
--- yellow #f4f5b3
colors.accent2 = hsb(61, 27, 96)
--- purple
colors.accent3 = hsb(253, 27, 96)
--- pale red
colors.accent4 = hsb(359, 27, 96)

--- blue #50b7f2
colors.diagnostics0 = hsb(202, 67, 95)
--- orange #f2b450
colors.diagnostics1 = hsb(37, 67, 95)
--- red #f25053
colors.diagnostics2 = hsb(359, 67, 95)

return colors
