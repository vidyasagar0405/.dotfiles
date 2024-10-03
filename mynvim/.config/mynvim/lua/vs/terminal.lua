-- Store the window and buffer ID globally
local lazygit_win = nil
local lazygit_buf = nil

-- Function to toggle Lazygit in a floating terminal
function Toggle_floating_lazygit()
    -- Check if the floating window already exists
    if lazygit_win and vim.api.nvim_win_is_valid(lazygit_win) then
        -- Close the window if it's open
        vim.api.nvim_win_close(lazygit_win, true)
        lazygit_win = nil
        lazygit_buf = nil
    else
        -- Set floating window dimensions
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local col = math.floor((vim.o.columns - width) / 2)
        local row = math.floor((vim.o.lines - height) / 2)

        -- Create a new buffer for the terminal
        lazygit_buf = vim.api.nvim_create_buf(false, true)

        -- Set floating window options
        local opts = {
            style = "minimal",
            relative = "editor",
            width = width,
            height = height,
            col = col,
            row = row,
            border = "rounded",
        }

        -- Open the floating window
        lazygit_win = vim.api.nvim_open_win(lazygit_buf, true, opts)

        -- Run Lazygit in the terminal
        vim.fn.termopen("lazygit")

        -- Set some terminal options
        vim.api.nvim_buf_set_option(lazygit_buf, "buflisted", false)
        vim.api.nvim_win_set_option(lazygit_win, "winhl", "Normal:Normal")

        -- Automatically enter insert mode
        vim.api.nvim_command("startinsert")
    end
end
