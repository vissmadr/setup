local group = vim.api.nvim_create_augroup("SetupGeneral", { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype == "terminal" then
      -- Spell is window-local; also disable it when reopening a terminal buffer.
      vim.opt_local.spell = false
    end
  end,
  desc = "Disable spelling in terminal buffers",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(args)
    -- Filetype plugins may run after this callback; apply our preference last.
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.bo[args.buf].formatoptions = vim.bo[args.buf].formatoptions:gsub("[cro]", "")
      end
    end)
  end,
  desc = "Keep comment continuation manual",
})
