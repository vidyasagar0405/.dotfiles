return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<leader>h", function()
                harpoon:list():add()
            end, { desc = "Add File to Harpoon" })
            vim.keymap.set("n", "<leader>H", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "Open Harpoon menu" })

            vim.keymap.set("n", "<leader>1", function()
                harpoon:list():select(1)
            end, { desc = "Harpoon to File 1" })
            vim.keymap.set("n", "<leader>2", function()
                harpoon:list():select(2)
            end, { desc = "Harpoon to File 2" })
            vim.keymap.set("n", "<leader>3", function()
                harpoon:list():select(3)
            end, { desc = "Harpoon to File 3" })
            vim.keymap.set("n", "<leader>4", function()
                harpoon:list():select(4)
            end, { desc = "Harpoon to File 4" })
            vim.keymap.set("n", "<leader>5", function()
                harpoon:list():select(5)
            end, { desc = "Harpoon to File 5" })
            vim.keymap.set("n", "<leader>!", function()
                harpoon:list():replace_at(1)
            end, { desc = "Add File to Harpoon 1" })
            vim.keymap.set("n", "<leader>@", function()
                harpoon:list():replace_at(2)
            end, { desc = "Add File to Harpoon 2" })
            vim.keymap.set("n", "<leader>#", function()
                harpoon:list():replace_at(3)
            end, { desc = "Add File to Harpoon 3" })
            vim.keymap.set("n", "<leader>$", function()
                harpoon:list():replace_at(4)
            end, { desc = "Add File to Harpoon 4" })
            vim.keymap.set("n", "<leader>%", function()
                harpoon:list():replace_at(4)
            end, { desc = "Add File to Harpoon 5" })
        end,
    },
}
