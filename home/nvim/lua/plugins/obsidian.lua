return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "vault",
				path = "~/core/vault/",
			},
			{
				name = "grappling",
				path = "~/core/grappling/",
			},
			{
				name = "accounts",
				path = "~/data/accounts/",
			},
		},

		notes_subdir = "nodes",

		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			substitutions = {},
		},

		attachments = {
			img_folder = "resources",
		},

		ui = {
			enable = false,
		},

		note_id_func = function(title)
			return title
		end,

		disable_frontmatter = true,
	},
}
