-- File: ~/.config/nvim/lua/draw_comma_line.lua
local M = {}

function M.draw_line()
  -- Set the highlight group; you can change the color here using a hex value or color name.
  vim.api.nvim_set_hl(0, "BlueLine", { fg = "green" })

  -- Create (or reuse) a namespace for these extmarks
  local ns = vim.api.nvim_create_namespace('comma_line')

  -- Use the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)

  -- Clear previous extmarks in this namespace to avoid duplicates
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  -- Loop over each line in the buffer
  for i = 0, line_count - 1 do
    local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1] or ""
    local in_double = false
    local in_single = false

    -- Iterate over each character (1-indexed)
    for pos = 1, #line do
      local char = line:sub(pos, pos)
      if char == '"' then
        in_double = not in_double
      elseif char == "'" then
        in_single = not in_single
      elseif (char == "," or char == "\t") and not in_double and not in_single then
        -- Place an extmark at the character's column (0-indexed)
        vim.api.nvim_buf_set_extmark(bufnr, ns, i, pos - 1, {
          virt_text = {{"▎", "BlueLine"}},
          virt_text_pos = "overlay",
          hl_mode = "combine",
          strict = false,
        })
      end
    end
  end
end

-- Create a user command that calls our function
vim.api.nvim_create_user_command('DrawCommaLine', function()
  M.draw_line()
end, {})

return M
