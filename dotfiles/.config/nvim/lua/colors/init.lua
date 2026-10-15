-- Color scheme entry point.
-- Loads palette + theme, then applies all highlight groups.
-- Loaded through :colorscheme setup.

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
function M.apply()
  for _, name in ipairs({ "treesitter", "markdown", "lsp", "syntax", "editor", "diagnostics", "diff", "plugins" }) do
    apply(require("colors.highlights." .. name))
  end
end

return M
