return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local snippets = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          snippets.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = require("keymaps").completion(cmp, snippets),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, { { name = "buffer" } }),
    })
  end,
}
