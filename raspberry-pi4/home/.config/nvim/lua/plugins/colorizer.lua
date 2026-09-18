return {
	"NvChad/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			filetypes = { "*" },
			options = {
				parsers = {
					css = true,
					names = { enable = false },
				},
			},
		})
	end,
}
