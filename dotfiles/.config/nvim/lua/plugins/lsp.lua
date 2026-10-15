local servers = { "ts_ls", "html", "cssls", "jsonls", "marksman", "zls", "lua_ls" }

return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
      vim.lsp.config("ts_ls", { filetypes = { "javascript", "typescript" } })
      vim.lsp.config("marksman", { filetypes = { "markdown" } })
      vim.lsp.config("lua_ls", {
        on_init = function(client)
          local root = client.root_dir
          if root and (vim.uv.fs_stat(root .. "/.luarc.json") or vim.uv.fs_stat(root .. "/.luarc.jsonc")) then
            return
          end
          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
          })
        end,
      })
      require("mason-lspconfig").setup({ ensure_installed = servers, automatic_enable = servers })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
