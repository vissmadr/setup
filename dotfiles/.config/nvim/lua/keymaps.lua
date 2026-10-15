-- All custom bindings live here, including plugin and buffer-local bindings.
-- Plugin specs consume the tables below so Lazy can load on the first keypress.
local M = {}
local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigation (the reversed jump-list keys are intentional).
map("n", "<C-o>", "<C-i>", { desc = "Jump forward" })
map("n", "<C-i>", "<C-o>", { desc = "Jump back" })

-- Terminal and window sizing.
map("n", "<leader>1", "<cmd>terminal<CR>", { desc = "Terminal" })
map("t", "<C-3>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
map("n", "<C-A-h>", "<C-w><", { desc = "Decrease width" })
map("n", "<C-A-j>", "<C-w>-", { desc = "Decrease height" })
map("n", "<C-A-k>", "<C-w>+", { desc = "Increase height" })
map("n", "<C-A-l>", "<C-w>>", { desc = "Increase width" })

-- Display toggles and search.
map("n", "<leader>z", "<cmd>setlocal number!<CR>", { desc = "Toggle numbers" })
map("n", "<leader>x", "<cmd>setlocal wrap!<CR>", { desc = "Toggle wrapping" })
-- Built-in spelling keys: z= suggests, zg remembers a word, ]s/[s navigate.
map("n", "<leader>v", "<cmd>setlocal spell!<CR>", { desc = "Toggle spelling" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Built-in diagnostics and LSP actions.
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Diagnostic" })
map("n", "<leader>de", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "x" }, "<leader>dr", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })

-- Oil: file browser.
M.oil = { { "<leader>a", "<cmd>Oil<CR>", desc = "Files" } }

-- Telescope: files, text, diagnostics, and LSP locations.
M.telescope = {
  { "<leader>q", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>w", "<cmd>Telescope live_grep<CR>", desc = "Search text" },
  { "<leader>e", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
  { "<leader>r", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
  { "<leader>t", "<cmd>Telescope<CR>", desc = "Pickers" },
  { "<leader>dq", "<cmd>Telescope lsp_definitions<CR>", desc = "Definitions" },
  { "<leader>dw", "<cmd>Telescope lsp_references<CR>", desc = "References" },
}

-- Aerial: symbols and Markdown headings.
M.aerial = { { "<leader>s", "<cmd>AerialOpen float<CR>", desc = "Symbols and headings" } }

-- Leap: jump within a window or across windows.
M.leap = {
  { "s", "<Plug>(leap)", mode = { "n", "x", "o" }, desc = "Leap" },
  { "S", "<Plug>(leap-from-window)", desc = "Leap across windows" },
}

-- Diffview: changes and file history.
M.diffview = {
  { "<leader>ff", "<cmd>DiffviewOpen<CR>", desc = "Open diff" },
  { "<leader>fd", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
  { "<leader>fq", "<cmd>DiffviewClose<CR>", desc = "Close diff" },
}

-- Conform: format the buffer or current visual selection.
M.conform = {
  {
    "<leader>d=",
    function()
      require("conform").format({ async = true })
    end,
    mode = { "n", "x" },
    desc = "Format buffer or selection",
  },
}

-- Colorizer: inline color previews.
M.colorizer = { { "<leader>c", "<cmd>ColorizerToggle<CR>", desc = "Toggle color previews" } }

-- Obsidian: notes, links, and templates.
M.obsidian = {
  { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian" },
  { "<leader>oh", "<cmd>ObsidianCheck<CR>", desc = "Obsidian health" },
  { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note" },
  { "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename note" },
  { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert template" },
  { "<leader>oe", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find notes" },
  { "<leader>ow", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
  { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Note links" },
  { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
}

-- Completion bindings are built only when cmp loads.
-- preset.insert also supplies Ctrl+n/Ctrl+p and arrow-key selection.
function M.completion(cmp, snippets)
  return cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept only an explicitly selected item.
    -- Keep snippet jumps inside the active snippet; otherwise retain the normal key.
    ["<C-l>"] = cmp.mapping(function(fallback)
      if snippets.expand_or_locally_jumpable() then
        snippets.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function(fallback)
      if snippets.locally_jumpable(-1) then
        snippets.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  })
end

-- Obsidian installs these only in vault buffers; other files keep normal gf/Enter.
M.obsidian_buffer = {
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
}

-- Called by the Markdown ftplugin; counted motions still use physical lines.
function M.markdown()
  for key, display in pairs({ j = "gj", k = "gk" }) do
    vim.keymap.set({ "n", "x" }, key, function()
      return vim.v.count == 0 and display or key
    end, { buffer = true, expr = true, desc = "Move by display line unless counted" })
  end
  vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
    .. "\nsilent! nunmap <buffer> j\nsilent! nunmap <buffer> k"
    .. "\nsilent! xunmap <buffer> j\nsilent! xunmap <buffer> k"
end

-- Unmodified plugin defaults: Oil/Diffview/Telescope use their own window-local
-- controls; mini.pairs handles paired delimiters; neoscroll smooths Ctrl+u/d/b/f,
-- Ctrl+y/e and zt/zz/zb. Use :verbose map <key> to see a live binding's owner.
-- Ctrl+1 opens a disposable shell-command buffer. ZZ keeps Vim's save-and-quit;
-- ZQ returns a failure status so Bash leaves the original command untouched.
function M.command_editor()
  vim.bo.undofile = false
  vim.bo.swapfile = false
  map("n", "ZQ", "<cmd>cquit<CR>", { buffer = true, desc = "Cancel command edit" })
end

return M
