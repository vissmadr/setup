return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Main branch no longer auto-registers filetype -> parser aliases.
    -- Register the ones where the filetype name differs from the parser name.
    vim.treesitter.language.register("tsx",        "typescriptreact")
    vim.treesitter.language.register("javascript", "javascriptreact")
    vim.treesitter.language.register("bash",       "sh")

    -- Declarative parser install list. Run :TSUpdate after editing.
    ts.install({
      "bash", "c", "cpp", "css", "diff", "glsl", "hlsl", "html",
      "javascript", "json", "lua", "markdown", "markdown_inline",
      "query", "sql", "toml", "tsx", "typescript", "vim", "vimdoc",
      "yaml",
    })

    -- Enable highlighting for these filetypes.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "bash", "c", "cpp", "css", "diff", "glsl", "hlsl", "html",
        "javascript", "javascriptreact", "json", "lua", "markdown",
        "query", "sh", "sql", "toml", "tsx", "typescript",
        "typescriptreact", "vim", "yaml",
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
