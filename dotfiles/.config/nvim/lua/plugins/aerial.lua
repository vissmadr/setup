return {
	"stevearc/aerial.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			highlight_on_jump = 200,
			layout = {
				max_width = { 80, 0.5 },
				min_width = 30,
				resize_to_content = true,
			},
		})
	end,
}
