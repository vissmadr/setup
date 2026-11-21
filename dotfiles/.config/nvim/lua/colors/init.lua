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

  -- Match the ANSI colors in Foot and Alacritty for nested terminals.
  local p = M.palette
  local terminal_colors = {
    p.sumiInk0, p.autumnRed, p.autumnGreen, p.boatYellow2, p.crystalBlue, p.oniViolet, p.waveAqua1, p.oldWhite,
    p.fujiGray, p.samuraiRed, p.springGreen, p.carpYellow, p.springBlue, p.springViolet1, p.waveAqua2, p.vissWhite2,
  }
  for index, color in ipairs(terminal_colors) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

return M
