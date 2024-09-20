return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "rose-pine/neovim", name = "rose-pine" },

    -- require("catppuccin").setup({
    --   flavour = "mocha",
    --   transparent_background = false,
    --   show_end_of_buffer = true,
    -- }),
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-mocha",
        },
    },
}
