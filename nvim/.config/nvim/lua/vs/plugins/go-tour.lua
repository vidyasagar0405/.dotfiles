return {
	dir = "~/github.com/probe/lua/go-tour.nvim",
	dependencies = { "neovim/nvim-lspconfig" }, -- Optional, for better Go integration
	config = function()
		require("go-tour").setup()
	end,
}
