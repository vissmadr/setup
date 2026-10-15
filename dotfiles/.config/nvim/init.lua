if vim.fn.has("nvim-0.12") == 0 then
  error("This configuration requires Neovim 0.12 or newer")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("keymaps")
require("autocommands")

vim.cmd.colorscheme("setup")

require("lazy").setup({ { import = "plugins" } }, {
  defaults = { version = false },
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
