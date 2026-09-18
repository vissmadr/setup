local t = require("colors.theme")

return {
  -- Variables
  ["@variable"]                   = { fg = t.syntax.variable },
  ["@variable.builtin"]           = { fg = t.syntax.builtin },
  ["@variable.parameter"]         = { fg = t.syntax.parameter },
  ["@variable.parameter.builtin"] = { fg = t.syntax.builtin },
  ["@variable.member"]            = { fg = t.syntax.property },

  -- Constants
  ["@constant"]         = { fg = t.syntax.constant },
  ["@constant.builtin"] = { fg = t.syntax.builtin },
  ["@constant.macro"]   = { link = "@constant" },

  -- Modules
  ["@module"]         = { fg = t.syntax.module },
  ["@module.builtin"] = { link = "@module" },

  -- Labels
  ["@label"] = { fg = t.syntax.exception },

  -- Strings
  ["@string"]                = { fg = t.syntax.string },
  ["@string.documentation"]  = { link = "@comment.documentation" },
  ["@string.regexp"]         = { fg = t.syntax.regexp },
  ["@string.escape"]         = { link = "@character.special" },
  ["@string.special"]        = { link = "@character.special" },
  ["@string.special.symbol"] = { link = "@character.special" },
  ["@string.special.path"]   = { link = "@character.special" },
  ["@string.special.url"]    = { fg = t.syntax.specialchar, italic = true, underline = true },

  -- Characters
  ["@character"]         = { fg = t.syntax.string },
  ["@character.special"] = { fg = t.syntax.specialchar },

  -- Numbers & booleans
  ["@number"]       = { fg = t.syntax.number },
  ["@number.float"] = { link = "@number" },
  ["@boolean"]      = { link = "@number" },

  -- Types
  ["@type"]            = { fg = t.syntax.type },
  ["@type.builtin"]    = { link = "@type" },
  ["@type.definition"] = { link = "@type" },

  -- Attributes
  ["@attribute"]         = { fg = t.syntax.special },
  ["@attribute.builtin"] = { fg = t.syntax.builtin },

  -- Properties
  ["@property"] = { fg = t.syntax.property },

  -- Functions
  ["@function"]             = { fg = t.syntax.procedure },
  ["@function.builtin"]     = { fg = t.syntax.builtin },
  ["@function.call"]        = { link = "@function" },
  ["@function.macro"]       = { link = "@function" },
  ["@function.method"]      = { link = "@function" },
  ["@function.method.call"] = { link = "@function.method" },

  -- Constructors & operators
  ["@constructor"] = { fg = t.syntax.special },
  ["@operator"]    = { fg = t.syntax.operator },

  -- Keywords
  ["@keyword"]                     = { fg = t.syntax.keyword, italic = true },
  ["@keyword.coroutine"]           = { link = "@keyword" },
  ["@keyword.function"]            = { link = "@keyword" },
  ["@keyword.operator"]            = { link = "@operator" },
  ["@keyword.import"]              = { fg = t.syntax.preproc },
  ["@keyword.type"]                = { link = "@keyword" },
  ["@keyword.modifier"]            = { link = "@keyword" },
  ["@keyword.repeat"]              = { link = "@keyword" },
  ["@keyword.return"]              = { link = "@keyword" },
  ["@keyword.debug"]               = { fg = t.syntax.special },
  ["@keyword.exception"]           = { fg = t.syntax.exception },
  ["@keyword.conditional"]         = { link = "@keyword" },
  ["@keyword.conditional.ternary"] = { link = "@operator" },
  ["@keyword.directive"]           = { fg = t.syntax.preproc },
  ["@keyword.directive.define"]    = { fg = t.syntax.preproc },

  -- Punctuation
  ["@punctuation.delimiter"] = { fg = t.syntax.delimiter },
  ["@punctuation.bracket"]   = { fg = t.syntax.delimiter },
  ["@punctuation.special"]   = { fg = t.syntax.special },

  -- Comments
  ["@comment"]               = { fg = t.syntax.comment },
  ["@comment.documentation"] = { link = "@comment" },
  ["@comment.error"]         = { fg = t.diag.error, underline = true },
  ["@comment.warning"]       = { fg = t.diag.warning, underline = true },
  ["@comment.todo"]          = { fg = t.diag.info, underline = true },
  ["@comment.note"]          = { fg = t.diag.hint, underline = true },

  -- Tags (HTML/XML)
  ["@tag"]           = { fg = t.syntax.type },
  ["@tag.builtin"]   = { fg = t.syntax.builtin },
  ["@tag.attribute"] = { fg = t.syntax.property },
  ["@tag.delimiter"] = { fg = t.syntax.delimiter },
}
