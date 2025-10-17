local c = require("colors/colors")
local u = require("colors/utilities")

u.setHL(0, "healthSuccess", { fg = c.diag.ok })
u.setHL(0, "healthWarning", { fg = c.diag.warning })
u.setHL(0, "healthError",   { fg = c.diag.error })

-- Telescope --
u.setHL(0, "TelescopeBorder", { fg = c.ui.float.border })
u.setHL(0, "TelescopeTitle", { fg = c.ui.special })
u.cmd("hi! link TelescopeSelection CursorLine")
u.cmd("hi! link TelescopeSelectionCaret CursorLineNr")
