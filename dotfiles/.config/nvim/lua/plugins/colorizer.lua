return {
  "NvChad/nvim-colorizer.lua",
  cmd = "ColorizerToggle",
  keys = require("keymaps").colorizer,
  opts = {
    filetypes = { "css", "scss", "html", "javascript", "typescript", "lua", "toml", "json", "jsonc" },
    options = { parsers = { css = true, names = { enable = false } } },
  },
}
