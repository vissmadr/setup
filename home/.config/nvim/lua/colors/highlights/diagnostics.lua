local t = require("colors.theme")

return {
  -- Base diagnostic groups
  DiagnosticError = { fg = t.diag.error },
  DiagnosticWarn  = { fg = t.diag.warning },
  DiagnosticInfo  = { fg = t.diag.info },
  DiagnosticHint  = { fg = t.diag.hint },
  DiagnosticOk    = { fg = t.diag.ok },

  -- Virtual text
  DiagnosticVirtualTextError = { link = "DiagnosticError" },
  DiagnosticVirtualTextWarn  = { link = "DiagnosticWarn" },
  DiagnosticVirtualTextInfo  = { link = "DiagnosticInfo" },
  DiagnosticVirtualTextHint  = { link = "DiagnosticHint" },
  DiagnosticVirtualTextOk    = { link = "DiagnosticOk" },

  -- Virtual lines
  DiagnosticVirtualLinesError = { link = "DiagnosticError" },
  DiagnosticVirtualLinesWarn  = { link = "DiagnosticWarn" },
  DiagnosticVirtualLinesInfo  = { link = "DiagnosticInfo" },
  DiagnosticVirtualLinesHint  = { link = "DiagnosticHint" },
  DiagnosticVirtualLinesOk    = { link = "DiagnosticOk" },

  -- Underlines
  DiagnosticUnderlineError = { sp = t.diag.error, undercurl = true },
  DiagnosticUnderlineWarn  = { sp = t.diag.warning, undercurl = true },
  DiagnosticUnderlineInfo  = { sp = t.diag.info, undercurl = true },
  DiagnosticUnderlineHint  = { sp = t.diag.hint, undercurl = true },
  DiagnosticUnderlineOk    = { sp = t.diag.ok, undercurl = true },

  -- Floating windows
  DiagnosticFloatingError = { link = "DiagnosticError" },
  DiagnosticFloatingWarn  = { link = "DiagnosticWarn" },
  DiagnosticFloatingInfo  = { link = "DiagnosticInfo" },
  DiagnosticFloatingHint  = { link = "DiagnosticHint" },
  DiagnosticFloatingOk    = { link = "DiagnosticOk" },

  -- Sign column
  DiagnosticSignError = { fg = t.diag.error },
  DiagnosticSignWarn  = { fg = t.diag.warning },
  DiagnosticSignInfo  = { fg = t.diag.info },
  DiagnosticSignHint  = { fg = t.diag.hint },
  DiagnosticSignOk    = { fg = t.diag.ok },
}
