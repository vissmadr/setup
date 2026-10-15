return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  ft = "markdown",
  cmd = {
    "ObsidianOpen",
    "ObsidianCheck",
    "ObsidianNew",
    "ObsidianRename",
    "ObsidianTemplate",
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianLinks",
    "ObsidianBacklinks",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  keys = require("keymaps").obsidian,
  opts = {
    workspaces = {
      { name = "vault", path = "~/core/vault/" },
      { name = "grappling", path = "~/core/grappling/" },
    },

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
      return title and title ~= "" and title or os.date("%Y%m%d-%H%M%S")
    end,

    disable_frontmatter = true,

    mappings = require("keymaps").obsidian_buffer,
  },
}
