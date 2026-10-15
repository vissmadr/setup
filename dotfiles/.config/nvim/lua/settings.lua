local options = vim.opt

options.spell = true     -- Check spelling by default; Space v toggles it per window.
options.spelllang = "en" -- Use the English dictionary.

-- Keep the inline explanations aligned when formatting this file.
-- stylua: ignore start

-- Files and search.
options.clipboard = "unnamedplus"  -- Use the system clipboard for yanks and pastes.
options.swapfile = false           -- Avoid swap files alongside project files.
options.undofile = true            -- Keep undo history between sessions.
options.ignorecase = true          -- Search without case sensitivity by default.
options.smartcase = true           -- Uppercase in a search makes it case-sensitive.

-- Indentation (filetype settings can override these).
options.smartindent = true     -- Indent new lines using surrounding code.
options.expandtab = true       -- Insert spaces instead of tabs.
options.shiftwidth = 2         -- Indent width; Zig overrides this to four.
options.tabstop = 2            -- Display width of a literal tab.
options.softtabstop = 2        -- Spaces inserted/removed by Tab and Backspace.
options.iskeyword:remove("_")  -- Treat snake_case parts as separate words.

-- Windows and folds.
options.equalalways = false    -- Keep existing split sizes when opening/closing windows.
options.splitright = true      -- Open vertical splits on the right.
options.splitbelow = true      -- Open horizontal splits below.
options.wrap = false           -- Keep code unwrapped; Markdown enables soft wrapping.
options.foldmethod = "indent"  -- Fallback folding when no parser is active.
options.foldlevel = 99         -- Start with folds open.
options.winborder = "rounded"  -- Default border for floating windows.

-- Interface.
options.laststatus = 3          -- One statusline shared by all windows.
options.number = false          -- Hide line numbers until toggled with Space z.
options.relativenumber = false  -- Use absolute numbers when enabled.
options.signcolumn = "yes"      -- Reserve space for diagnostics and Git signs.
options.cursorline = false      -- Keep the current line background unobtrusive.
options.termguicolors = true    -- Use the full theme palette.
options.showtabline = 0         -- Hide the tab bar.
options.showmode = false        -- The statusline already shows the mode.
options.shortmess:append("I")   -- Skip the startup intro.

-- Whitespace.
options.list = true                                          -- Show otherwise invisible whitespace.
options.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }  -- Tabs, trailing spaces, nonbreaking spaces.
options.fillchars = { eob = " ", fold = " " }                -- Hide end-of-buffer tildes and fold filler.

-- Keep diagnostics visible without inserting text into the document.
vim.diagnostic.config({
  virtual_text = false,     -- Read messages in the diagnostic float (Space dd).
  signs = true,             -- Mark affected lines in the sign column.
  underline = true,         -- Highlight the affected range.
  update_in_insert = false, -- Wait until leaving insert mode to refresh.
  severity_sort = true,     -- Show errors before warnings and hints.
})

-- stylua: ignore end

-- These configs use Lua plugins; external language providers are unnecessary.
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
