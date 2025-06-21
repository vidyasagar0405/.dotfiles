return {
	"mrcjkb/haskell-tools.nvim",
	version = "^5", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		local ht = require("haskell-tools")
		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- CodeLens
		vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)

		-- Hoogle search
		vim.keymap.set("n", "<space>hss", ht.hoogle.hoogle_signature, opts)

		-- Evaluate all code snippets
		vim.keymap.set("n", "<space>hes", ht.lsp.buf_eval_all, opts)

		-- Toggle GHCi repl for the current package
		vim.keymap.set("n", "<leader>hrr", ht.repl.toggle, opts)

		-- Toggle GHCi repl for the current buffer
		vim.keymap.set("n", "<leader>hrb", function()
			ht.repl.toggle(vim.api.nvim_buf_get_name(0))
		end, opts)

		-- Quit repl
		vim.keymap.set("n", "<leader>hrq", ht.repl.quit, opts)
	end,
}
