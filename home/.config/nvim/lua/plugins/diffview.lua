return {
  'sindrets/diffview.nvim',

  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    require("diffview").setup({
      -- diff_binaries = false,    -- Show diffs for binaries
      enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
      use_icons = true,         -- Requires nvim-web-devicons

      hooks = {
        diff_buf_win_enter = function()
          vim.opt_local.foldenable = false
          -- vim.opt_local.foldlevel = 99  -- Alternative: set very high foldlevel to expand all
        end,
      },
    })
  end,
}

