return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
        -- "ibhagwan/fzf-lua",              -- optional
        -- "echasnovski/mini.pick",         -- optional
    },
    config = function()

        local neogit = require "neogit"
        vim.keymap.set("n", "<leader>gg", function() neogit.open() end, { desc = "Open Neo[g]it" })
        vim.keymap.set("n", "<leader>gG", function() neogit.open({ kind = "split" }) end, { desc = "Open Neo[g]it in Split" })
        vim.keymap.set("n", "<leader>gc", function() neogit.open({"commit"}) end, { desc = "Neogit commit" })
        vim.keymap.set("n", "<leader>gP", function() neogit.open({"push"}) end, { desc = "Neogit Push" })
        vim.keymap.set("n", "<leader>gp", function() neogit.open({"push"}) end, { desc = "Neogit pull" })

    end
}

