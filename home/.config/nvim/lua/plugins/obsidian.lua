return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		dir = "~/core/vault/",

		notes_subdir = "nodes",
		new_notes_location = "notes_subdir",
		attachments = { img_folder = "resources" },

		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			substitutions = {},
		},

		ui = { enable = false },

		note_id_func = function(title)
			return title
		end,

		disable_frontmatter = true,

		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<cr>"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
		},
	},
}
