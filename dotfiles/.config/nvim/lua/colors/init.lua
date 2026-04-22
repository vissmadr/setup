-- Color scheme entry point.
-- Loads palette + theme, then applies all highlight groups.
-- Usage: require("colors") in your init.lua

local M = {}

M.palette = require("colors.palette")
M.theme = require("colors.theme")

local function apply(groups)
  for name, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, name, opts)
  end
end

-- Apply highlights in order.
-- 1. Treesitter first (primary syntax engine)
-- 2. LSP (augments treesitter)
-- 3. legacy syntax (fallback), editor UI, diagnostics, diff, plugins.
apply(require("colors.highlights.treesitter"))
apply(require("colors.highlights.markdown"))
apply(require("colors.highlights.lsp"))
apply(require("colors.highlights.syntax"))
apply(require("colors.highlights.editor"))
apply(require("colors.highlights.diagnostics"))
apply(require("colors.highlights.diff"))
apply(require("colors.highlights.plugins"))

return M
