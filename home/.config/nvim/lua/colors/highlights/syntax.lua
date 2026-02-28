-- Legacy Vim syntax groups.
-- These link to treesitter captures so non-treesitter buffers
-- still get consistent colors.

local t = require("colors.theme")

return {
  -- Comments
  Comment        = { link = "@comment" },
  SpecialComment = { link = "@comment.documentation" },

  -- Constants & literals
  Constant  = { link = "@constant" },
  String    = { link = "@string" },
  Character = { link = "@character" },
  Number    = { link = "@number" },
  Boolean   = { link = "@boolean" },
  Float     = { link = "@number.float" },

  -- Identifiers
  Identifier = { fg = t.syntax.identifier },
  Function   = { link = "@function" },

  -- Statements & keywords
  Statement   = { link = "@keyword" },
  Conditional = { link = "@keyword.conditional" },
  Repeat      = { link = "@keyword.repeat" },
  Label       = { link = "@keyword" },
  Operator    = { link = "@operator" },
  Keyword     = { link = "@keyword" },
  Exception   = { link = "@keyword.exception" },

  -- Preprocessor
  PreProc   = { link = "@keyword.directive" },
  Include   = { link = "@keyword.import" },
  Define    = { link = "@keyword.directive.define" },
  Macro     = { link = "@constant.macro" },
  PreCondit = { link = "@keyword.directive" },

  -- Types
  Type         = { link = "@type" },
  StorageClass = { link = "@keyword.modifier" },
  Structure    = { link = "@keyword.type" },
  Typedef      = { link = "@type" },

  -- Specials
  Special    = { fg = t.syntax.special },
  SpecialChar = { link = "@character.special" },
  Tag        = { link = "@tag" },
  Delimiter  = { link = "@punctuation.delimiter" },
  Debug      = { link = "@keyword.debug" },

  -- Text formatting
  Underlined = { underline = true },
  Bold       = { bold = true },
  Italic     = { italic = true },

  -- Misc
  Ignore  = { fg = t.ui.nontext },
  Error   = { fg = t.diag.error },
  Todo    = { fg = t.diag.info, underline = true },
  Added   = { fg = t.vcs.added, underline = true },
  Changed = { fg = t.vcs.changed, underline = true },
  Removed = { fg = t.vcs.removed, underline = true },
}
