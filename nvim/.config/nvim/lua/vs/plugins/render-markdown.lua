vim.cmd([[
  function! OpenMarkdownPreview(url)
    execute "silent !  zen-browser --new-window " . a:url
  endfunction
]])

return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		ft = { "markdown", "quarto" },
		render_modes = { "n", "c", "i" },
		config = {
			heading = { enabled = false },
			completions = { lsp = { enabled = true } },
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_auto_start = 1
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_browser = "brave"
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = 0,
				sync_scroll_type = "middle",
				hide_yaml_meta = 1,
				sequence_diagrams = {},
				flowchart_diagrams = {},
				content_editable = false,
				disable_filename = 0,
				toc = {},
			}
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_open_to_the_world = 0
			vim.g.mkdp_open_ip = ""
			vim.g.mkdp_echo_preview_url = 0
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
			vim.g.mkdp_markdown_css = ""
			vim.g.mkdp_highlight_css = ""
			vim.g.mkdp_port = ""
			vim.g.mkdp_page_title = "「${name}」"
			vim.g.mkdp_images_path = "/home/vs/.markdown_images"
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_theme = "dark"
			vim.g.mkdp_combine_preview = 0
			vim.g.mkdp_combine_preview_auto_refresh = 1

			vim.keymap.set("n", "<leader>p", function()
				vim.cmd("MarkdownPreview")
			end, { desc = "Add file to harpoon" })
		end,
	},
	{
		"hedyhli/markdown-toc.nvim",
		ft = "markdown", -- Lazy load on markdown filetype
		cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
		opts = {
			-- Your configuration here (optional)
		},
	},
}
