-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Escape and Clear hlsearch" })

-- Diagnostic keymaps
vim.keymap.set("n", "-d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "=d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- save
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR>")
vim.keymap.set({ "i", "x", "n", "s" }, "<C-sa>", "<cmd>wa<CR>")

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Move lines up ro down
vim.keymap.set("n", "J", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "K", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "J", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "K", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Up" })


-- Buffers
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })


vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })



-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
