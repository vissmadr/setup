local t = require("colors.theme")

return {
  -- Health check
  healthSuccess = { fg = t.diag.ok },
  healthWarning = { fg = t.diag.warning },
  healthError   = { fg = t.diag.error },

  -- Telescope
  TelescopeBorder        = { fg = t.ui.float.border },
  TelescopeTitle         = { fg = t.ui.special },
  TelescopeSelection     = { link = "CursorLine" },
  TelescopeSelectionCaret = { link = "CursorLineNr" },

  -- Aerial
  AerialLine     = { bg = t.ui.bg_cursorline },
  AerialClass    = { link = "@type" },
  AerialEnum     = { link = "@number" },
  AerialStruct   = { link = "@type" },
  AerialModule   = { link = "@module" },
  AerialFunction = { link = "@function" },
  AerialMethod   = { link = "@function.method" },

  -- Gitsigns
  -- Set these explicitly so the signcolumn bars don't inherit the `underline`
  -- from the legacy `Added` / `Changed` / `Removed` groups in syntax.lua.
  GitSignsAdd          = { fg = t.vcs.added },
  GitSignsChange       = { fg = t.vcs.changed },
  GitSignsDelete       = { fg = t.vcs.removed },
  GitSignsTopdelete    = { fg = t.vcs.removed },
  GitSignsChangedelete = { fg = t.vcs.changed },
  GitSignsUntracked    = { fg = t.ui.nontext },
}
