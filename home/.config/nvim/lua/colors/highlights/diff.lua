local c = require("colors/colors")
local u = require("colors/utilities")

u.setHL(0, "@diff.plus",  { fg = c.vcs.added })
u.setHL(0, "@diff.minus", { fg = c.vcs.removed })
u.setHL(0, "@diff.delta", { fg = c.vcs.changed })

u.setHL(0, "diffNewFile", { fg = c.vcs.added })
u.setHL(0, "diffOldFile", { fg = c.vcs.removed })
u.setHL(0, "diffChanged", { fg = c.vcs.changed })
u.setHL(0, "diffDeleted", { fg = c.vcs.removed })
u.setHL(0, "diffRemoved", { fg = c.vcs.removed })
u.setHL(0, "diffAdded",   { fg = c.vcs.added })

-- 	DiffAdd: Diff mode: Added line. diff.txt
u.setHL(0, "DiffAdd", { bg = c.diff.add })

-- DiffChange: Diff mode: Changed line. diff.txt
u.setHL(0, "DiffChange", { bg = c.diff.change })

-- DiffDelete: Diff mode: Deleted line. diff.txt
u.setHL(0, "DiffDelete", { fg = c.vcs.removed, bg = c.diff.delete })

-- DiffText: Diff mode: Changed text within a changed line. diff.txt
u.setHL(0, "DiffText", { bg = c.diff.text })

-- DiffTextAdd: Diff mode: Added text within a changed line.  Linked to hl-DiffText by default. diff.txt
u.cmd("hi! link DiffTextAdd DiffText")
