return {
	"stevearc/oil.nvim",
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	opts = {},
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,

			columns = { "icon" },

			win_options = {
				signcolumn = "yes",
				conceallevel = 0,
			},

			view_options = { show_hidden = true },

			-- delete_to_trash = false,
		})
	end,
}
