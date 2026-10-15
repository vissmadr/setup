return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = require("keymaps").telescope,
  opts = {
    defaults = {
      layout_strategy = "vertical",
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!.git",
      },
    },
    pickers = {
      find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!.git" } },
    },
  },
}
