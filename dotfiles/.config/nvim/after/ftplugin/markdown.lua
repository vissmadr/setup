vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.spell = true -- Toggle proofreading with Space v.
vim.opt_local.spelllang = "en"
vim.opt_local.conceallevel = 0
vim.opt_local.textwidth = 0
vim.opt_local.formatoptions:remove("t")

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
  .. "\nsetlocal wrap< linebreak< breakindent< spell< spelllang< conceallevel< textwidth< formatoptions<"

require("keymaps").markdown()
