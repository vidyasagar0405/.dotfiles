return{
    "ThePrimeagen/harpoon",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        vim.keymap.set("n", "<leader>h", function() require("harpoon.mark").add_file() end, { desc = "Add file to harpoon" })
        vim.keymap.set("n", "<leader>H", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Toggle harpoon quick menu" })
        vim.keymap.set("n", "<leader>cm", function() require("harpoon.cmd-ui").toggle_quick_menu() end, { desc = "Toggle harpoon cmd quick menu" })

        vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end, { desc = "Go to harpoon mark 1" })
        vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end, { desc = "Go to harpoon mark 2" })
        vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end, { desc = "Go to harpoon mark 3" })
        vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end, { desc = "Go to harpoon mark 4" })
        vim.keymap.set("n", "<leader>5", function() require("harpoon.ui").nav_file(5) end, { desc = "Go to harpoon mark 5" })

        vim.keymap.set("n", "<leader>!", function() require("harpoon.mark").set_current_at(1) end, { desc = "Add file to harpoon 1" })
        vim.keymap.set("n", "<leader>@", function() require("harpoon.mark").set_current_at(2) end, { desc = "Add file to harpoon 2" })
        vim.keymap.set("n", "<leader>#", function() require("harpoon.mark").set_current_at(3) end, { desc = "Add file to harpoon 3" })
        vim.keymap.set("n", "<leader>$", function() require("harpoon.mark").set_current_at(4) end, { desc = "Add file to harpoon 4" })
        vim.keymap.set("n", "<leader>%", function() require("harpoon.mark").set_current_at(5) end, { desc = "Add file to harpoon 5" })

        vim.keymap.set("n", "<leader>c1", function() require("harpoon.tmux").sendCommand(1, 1) end, { desc = "Send command 1 to tmux 1 harpoon" })

    end
}
