local t = require("colors.theme")

return {
  -- Inline formatting
  ["@markup.strong"] = { fg = t.markdown.strong, bold = true },
  ["@markup.italic"] = { fg = t.markdown.italic, italic = true },

  -- Headings
  ["@markup.heading"]   = { fg = t.markdown.heading, bold = true },
  ["@markup.heading.1"] = { fg = t.markdown.heading1, bold = true },
  ["@markup.heading.2"] = { fg = t.markdown.heading2, bold = true },
  ["@markup.heading.3"] = { fg = t.markdown.heading3, bold = true },
  ["@markup.heading.4"] = { fg = t.markdown.heading4, bold = true },
  ["@markup.heading.5"] = { fg = t.markdown.heading5, bold = true },
  ["@markup.heading.6"] = { fg = t.markdown.heading6, bold = true },

  -- Block elements
  ["@markup.quote"]     = { fg = t.markdown.quote, italic = true },
  ["@markup.raw"]       = { fg = t.markdown.raw },
  ["@markup.raw.block"] = { fg = t.markdown.raw },

  -- Links
  ["@markup.link"]       = { fg = t.markdown.link, bold = true },
  ["@markup.link.label"] = { link = "@markup.link" },

  -- Lists
  ["@markup.list"]           = { fg = t.markdown.fg },
  ["@markup.list.checked"]   = { fg = t.markdown.fg },
  ["@markup.list.unchecked"] = { fg = t.markdown.fg },

  -- Markdown-specific overrides
  ["@label.markdown"]              = { fg = t.markdown.label },
  ["@punctuation.special.markdown"] = { fg = t.markdown.fg },

  -- LSP overrides for markdown
  ["@lsp.type.class.markdown"]     = { link = "@markup.link" },
  ["@lsp.type.decorator.markdown"] = { fg = t.markdown.link },
}
