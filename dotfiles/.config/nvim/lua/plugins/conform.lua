return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = require("keymaps").conform,
  opts = {
    default_format_opts = { lsp_format = "fallback" },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      zig = { "zigfmt" },
    },
    formatters = {
      prettier = { prepend_args = { "--prose-wrap", "preserve" } },
    },
  },
}
