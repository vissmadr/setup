return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = require("keymaps").oil,
  opts = {
    default_file_explorer = true,
    columns = { "icon" },
    win_options = { signcolumn = "yes" },
    view_options = { show_hidden = true },
  },
}
