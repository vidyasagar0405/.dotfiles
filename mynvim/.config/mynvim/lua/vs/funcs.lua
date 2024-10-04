local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    -- function to run on closing the terminal
    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})


local varcall = Terminal:new({
    cmd = "python /home/vs/github/varcall/python/varcall/src/main.py",
    direction = "float",
    display_name = "varcall",
    dir = "/home/vs/github/varcall/python/varcall",
    close_on_exit = true,
})

function Lazygit_toggle()
    lazygit:toggle()
end

function Varcall()
    varcall:toggle()
end
-- Current keymaps active in config/keymaps.lua
-- vim.api.nvim_set_keymap("n", "<leader>vv", "<cmd>lua Varcall()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true })
