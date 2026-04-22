local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------------
---------- EDITOR ----------
----------------------------

-- Previous --
map("n", "<C-o>", "<C-i>", { noremap = true, silent = true })
map("n", "<C-i>", "<C-o>", { noremap = true, silent = true })

-- Terminal --
map({ "n", "v" }, "<leader>v", "<cmd>terminal<CR>", { desc = "Terminal" })
map("t", "<C-a>", "<C-\\><C-n>", { desc = "Terminal Unselect" })

-- Splits --
map({ "n", "v" }, "<C-A-h>", "<C-w><", { desc = "Decrease Width" })
map({ "n", "v" }, "<C-A-j>", "<C-w>-", { desc = "Decrease Height" })
map({ "n", "v" }, "<C-A-k>", "<C-w>+", { desc = "Increase Height" })
map({ "n", "v" }, "<C-A-l>", "<C-w>>", { desc = "Increase Width" })

-- Workspace --
map({ "n", "v" }, "<leader>z", "<cmd>set nu!<CR>", { desc = "Toggle Numbers" })
map({ "n", "v" }, "<leader>x", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap" })


-----------------------------
---------- PLUGINS ----------
-----------------------------

-- Leap --
map({ "n", "x", "o" }, "s", "<Plug>(leap)")
map("n", "S", "<Plug>(leap-from-window)")

-- Oil --
map({ "n", "v" }, "<leader>a", "<cmd>Oil<CR>", { desc = "Oil" })

-- Aerial --
map({ "n", "v" }, "<leader>s", "<cmd>AerialOpen float<CR>", { desc = "Aerial" })

-- Telescope --
map({ "n", "v" }, "<leader>q", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map({ "n", "v" }, "<leader>w", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map({ "n", "v" }, "<leader>e", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })
map({ "n", "v" }, "<leader>r", "<cmd>Telescope oldfiles<CR>", { desc = "Recent" })
map({ "n", "v" }, "<leader>t", "<cmd>Telescope<CR>", { desc = "Telescope" })

-- Diffview --
map({"n", "v"}, "<leader>ff", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
map({"n", "v"}, "<leader>fd", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview File History" })
map({"n", "v"}, "<leader>fq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })

-- LSP Target --
map({ "n", "v" }, "<leader>dd", vim.diagnostic.open_float, { desc = "Diagnostic" })
map({ "n", "v" }, "<leader>dq", "<cmd>Telescope lsp_definitions<CR>", { desc = "Definition" })
map({ "n", "v" }, "<leader>dw", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
map({ "n", "v" }, "<leader>de", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n", "v" }, "<leader>dr", vim.lsp.buf.code_action, { desc = "Code Action" })

-- LSP Global --
map({ "n", "v" }, "<leader>d=", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
