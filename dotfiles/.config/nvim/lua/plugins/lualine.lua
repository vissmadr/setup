return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    return {
      options = { globalstatus = true, theme = require("colors.extra.lualine").theme },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            function()
              -- Terminal names encode cwd/PID/command; show only the command name.
              local command = vim.api.nvim_buf_get_name(0):match("//%d+:(.*)$") or vim.o.shell
              return "Terminal · " .. vim.fn.fnamemodify(command, ":t")
            end,
            cond = function()
              return vim.bo.buftype == "terminal"
            end,
          },
          {
            "filename",
            path = 1,
            cond = function()
              return vim.bo.buftype ~= "terminal"
            end,
          },
        },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
