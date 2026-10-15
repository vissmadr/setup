return {
  "stevearc/aerial.nvim",
  cmd = { "AerialOpen", "AerialToggle" },
  keys = require("keymaps").aerial,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
    highlight_on_jump = 200,
    layout = { max_width = { 80, 0.5 }, min_width = 30, resize_to_content = true },
  },
}
