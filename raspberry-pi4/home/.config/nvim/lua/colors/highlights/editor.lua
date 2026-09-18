local t = require("colors.theme")

return {
  -- Normal text
  Normal   = { fg = t.ui.fg },
  NormalNC = { link = "Normal" },

  -- Cursor & selection
  CursorLine   = { bg = t.ui.bg_cursorline },
  CursorColumn = { link = "CursorLine" },
  Visual       = { bg = t.ui.bg_visual },
  VisualNOS    = { link = "Visual" },

  -- Search
  Search    = { bg = t.ui.bg_search },
  CurSearch = { fg = "#EEEEEE", bg = t.ui.bg_search, bold = true },
  IncSearch = { fg = "#111111", bg = t.diag.warning, bold = true },

  -- Concealed & special characters
  Conceal    = { fg = t.ui.special },
  NonText    = { fg = t.ui.nontext },
  Whitespace = { fg = t.ui.nontext },

  -- UI chrome
  Directory    = { fg = t.ui.directory },
  Title        = { fg = t.ui.special, bold = true },
  WinSeparator = { fg = t.ui.nontext },
  Folded       = { fg = t.ui.special },
  MatchParen   = { fg = t.ui.mode_msg, bold = true },

  -- Messages
  ModeMsg    = { fg = t.ui.mode_msg, bold = true },
  MoreMsg    = { fg = t.ui.more_msg },
  ErrorMsg   = { fg = t.diag.error },
  WarningMsg = { fg = t.diag.warning },
  Question   = { link = "MoreMsg" },

  -- Floating windows
  NormalFloat = { fg = t.ui.float.fg },
  FloatBorder = { fg = t.ui.float.border },
  FloatTitle  = { fg = t.ui.float.title, bg = t.ui.float.bg, bold = true },
  FloatFooter = { fg = t.ui.nontext, bg = t.ui.float.bg },

  -- Status line
  StatusLine       = { fg = "NONE", bg = t.ui.bg_gutter },
  StatusLineNC     = { link = "StatusLine" },
  StatusLineTerm   = { link = "StatusLine" },
  StatusLineTermNC = { link = "StatusLine" },

  -- Spelling
  SpellBad   = { sp = t.diag.error, undercurl = true },
  SpellCap   = { sp = t.diag.warning, undercurl = true },
  SpellLocal = { sp = t.diag.warning, undercurl = true },
  SpellRare  = { sp = t.diag.warning, undercurl = true },

  -- Misc
  WildMenu = { link = "Pmenu" },
}
