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
}
