return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  keys = require("keymaps").diffview,
  opts = {
    enhanced_diff_hl = true,
    hooks = {
      diff_buf_win_enter = function()
        vim.opt_local.foldenable = true
      end,
    },
  },
}
