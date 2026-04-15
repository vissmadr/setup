return {
  {
    "hrsh7th/nvim-cmp",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",         -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",           -- Source for buffer words
      "hrsh7th/cmp-path",             -- Source for filesystem paths
      "L3MON4D3/LuaSnip",             -- Snippet engine
      "saadparwaiz1/cmp_luasnip",     -- LuaSnip completion source
      "rafamadriz/friendly-snippets", -- Predefined snippets
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp", group_index = 2 },
          { name = "luasnip",  group_index = 2 },
          { name = "buffer",   group_index = 2 },
          { name = "path",     group_index = 2 },
        }),
      })
    end,
  },

  -- Provides default LSP configs under lsp/*.lua which vim.lsp.enable() reads.
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  {
    "mason-org/mason.nvim",

    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      require("mason").setup()

      -- Apply nvim-cmp capabilities to every server.
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      require("mason-lspconfig").setup({
        -- mason-lspconfig v2: auto-calls vim.lsp.enable() for installed servers.
        -- Set to a list of names to restrict, or `false` to disable entirely.
        automatic_enable = true,
      })
    end,
  },
}
