-- LSP semantic token highlights.
-- These link to treesitter groups so LSP tokens get consistent colors.

return {
  ["@lsp.type.class"]      = { link = "@type" },
  ["@lsp.type.comment"]    = { link = "@comment" },
  ["@lsp.type.decorator"]  = { link = "@attribute" },
  ["@lsp.type.enum"]       = { link = "@type" },
  ["@lsp.type.enumMember"] = { link = "@number" },
  ["@lsp.type.function"]   = { link = "@function" },
  ["@lsp.type.interface"]  = { link = "@type" },
  ["@lsp.type.keyword"]    = { link = "@keyword" },
  ["@lsp.type.macro"]      = { link = "@constant.macro" },
  ["@lsp.type.method"]     = { link = "@function.method" },
  ["@lsp.type.modifier"]   = { link = "@keyword.modifier" },
  ["@lsp.type.namespace"]  = { link = "@module" },
  ["@lsp.type.number"]     = { link = "@number" },
  ["@lsp.type.operator"]   = { link = "@operator" },
  ["@lsp.type.parameter"]  = { link = "@variable.parameter" },
  ["@lsp.type.property"]   = { link = "@property" },
  ["@lsp.type.regexp"]     = { link = "@string.regexp" },
  ["@lsp.type.string"]     = { link = "@string" },
  ["@lsp.type.struct"]     = { link = "@type" },
  ["@lsp.type.type"]       = { link = "@type" },
  ["@lsp.type.variable"]   = { link = "@variable" },

  -- Per-language overrides
  ["@lsp.type.comment.zig"] = {}, -- Disable: let treesitter handle Zig comments
}
