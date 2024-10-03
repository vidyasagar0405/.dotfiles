-- Keymaps are automatically loaded on the VeryLazy event
-- Defarevealult keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v", "x" }, "\\", "<cmd>Neotree toggle<CR>", { desc = "Neotree" })
vim.keymap.set({ "n", "v", "x", "i" }, "<C-c>", "<Esc>", { desc = "mapped Control-c to Esc" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
