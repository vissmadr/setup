local c = require("colors/colors")
local u = require("colors/utilities")

u.setHL(0, "AerialLine", { bg = c.ui.bg_p2 })

u.cmd("hi! link AerialClass @type")
u.cmd("hi! link AerialEnum @type")
u.cmd("hi! link AerialStruct @type")
u.cmd("hi! link AerialModule @module")
u.cmd("hi! link AerialFunction @function")
u.cmd("hi! link AerialMethod @function.method")
