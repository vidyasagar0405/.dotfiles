local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "rounded",
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
    cmd = "textual run --dev /home/vs/github/varcall/python/varcall/src/main.py",
    direction = "float",
    display_name = "varcall",
    dir = "/home/vs/github/varcall/python/varcall",
    close_on_exit = true,
})

-- local float_terminal = Terminal:new({
--     display_name = "Terminal",
--     direction = "float",
-- })

function Lazygit_toggle()
    lazygit:toggle()
end

function Varcall()
    varcall:toggle()
end

-- function Floating_terminal()
--     float_terminal:toggle()
-- end

--[[
    Current keymaps active in config/keymaps.lua
    vim.api.nvim_set_keymap("n", "<leader>vv", "<cmd>lua Varcall()<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true })
--]]


function GoTest(bufnr)
    local group = vim.api.nvim_create_augroup("GoTest", {clear = true})
    vim.fn.jobstart("go test", {
        stdout_buffered = true,
        on_stdout = function (_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
        on_stderr = function (_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
    })
end
--
-- vim.keymap.set("n", "<leader>got", "<cmd>lua GoTest()<CR>")
