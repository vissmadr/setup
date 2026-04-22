local t = require("colors.theme")

return {
  -- Treesitter diff captures
  ["@diff.plus"]  = { fg = t.vcs.added },
  ["@diff.minus"] = { fg = t.vcs.removed },
  ["@diff.delta"] = { fg = t.vcs.changed },

  -- Legacy diff syntax
  diffNewFile = { fg = t.vcs.added },
  diffOldFile = { fg = t.vcs.removed },
  diffChanged = { fg = t.vcs.changed },
  diffDeleted = { fg = t.vcs.removed },
  diffRemoved = { fg = t.vcs.removed },
  diffAdded   = { fg = t.vcs.added },

  -- Diff mode backgrounds
  DiffAdd     = { bg = t.diff.add },
  DiffChange  = { bg = t.diff.change },
  DiffDelete  = { fg = t.vcs.removed, bg = t.diff.delete },
  DiffText    = { bg = t.diff.text },
  DiffTextAdd = { link = "DiffText" },
}
