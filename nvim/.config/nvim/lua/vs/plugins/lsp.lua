return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					----------------------------------------------------------------------------------
					--- KEYMAPS
					----------------------------------------------------------------------------------
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Restart LSP
					-- map("<leader>l", vim.cmd("LspRestart"), "Restart LSP")

					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gim", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>td", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap.
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gde", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

			local util = require("lspconfig").util

			---------------------------------------------------------------------------------
			--- LSPs
			---------------------------------------------------------------------------------

			local servers = {
				-- clangd = {},
				---------------------------------------------------------------------------------
				--- R
				---------------------------------------------------------------------------------
				-- r_language_server = {},
				---------------------------------------------------------------------------------
				--- GO
				---------------------------------------------------------------------------------
				gopls = {},
				-- templ = {},
				---------------------------------------------------------------------------------
				--- Python
				---------------------------------------------------------------------------------
				pyright = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							ignore = { "*" },
							autoImportCompletions = false,
						},
					},
				},

				ruff = {},
				--------------------------------------------------------------------------------
				--- Rust
				--------------------------------------------------------------------------------
				-- rust_analyzer = {},

				--------------------------------------------------------------------------------
				--- Haskell
				--------------------------------------------------------------------------------
				-- hls = {
				-- 	cmd = { "/home/vs/.ghcup/bin/haskell-language-server-9.12.2~2.10.0.0" },
				-- },
				---
				---
				--------------------------------------------------------------------------------
				---Lua
				--------------------------------------------------------------------------------
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
							runtime = {
								version = "LuaJIT",
								path = vim.split(package.path, ";"),
							},
							-- diagnostics = {
							-- 	globals = { "love" },
							-- },
							workspace = {
								library = {
									-- Optionally, add LOVE2D stubs if available:
									"${3rd}/love2d/library",
								},
							},
							telemetry = { enable = false },
						},
					},
				},
				--------------------------------------------------------------------------------
				---Tail Wind CSS
				--------------------------------------------------------------------------------
				tailwindcss = {
					settings = {
						tailwindCSS = {
							hovers = true,
							suggestions = true,
							codeActions = true,
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})

			-- Remove Haskell if present
			ensure_installed = vim.tbl_filter(function(server)
				return server ~= "hls"
			end, ensure_installed)

			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			-- Configure nextflow_ls separately since it's not available in Mason
			require("lspconfig").nextflow_ls.setup({
				cmd = {
					"/usr/lib/jvm/java-17-openjdk/bin/java",
					"-jar",
					vim.fn.expand(
						"~/.local/share/nvim/mason/packages/nextflow-language-server/language-server-all.jar"
					),
				},
				filetypes = { "nextflow" },
				root_dir = util.root_pattern("nextflow.config", ".git"),
				capabilities = vim.lsp.protocol.make_client_capabilities(),
				settings = {
					nextflow = {
						files = {
							exclude = { ".git", ".nf-test", "work" },
						},
					},
				},
			})

			-- Configure nextflow_ls separately since it's not available in Mason
			require("lspconfig").ocamllsp.setup({
				cmd = {
					"/home/vs/.opam/ocaml5.2/bin/ocamllsp",
				},
				filetypes = { "ocaml" },
				root_dir = util.root_pattern(".ocamlformat", ".git", "main.ml"),
				capabilities = vim.lsp.protocol.make_client_capabilities(),
				handlers = handlers,
			})

			-- Configure nextflow_ls separately since it's not available in Mason
			require("lspconfig").hls.setup({
				cmd = {
					"/home/vs/.ghcup/bin/haskell-language-server-9.12.2~2.10.0.0",
				},
				filetypes = { "haskell", "lhaskell", "cabal" },
				root_dir = util.root_pattern(".git", "main.hs", "Main.hs", "*.cabal", "stack.yaml", "stack.yaml.lock"),
				capabilities = vim.lsp.protocol.make_client_capabilities(),
				handlers = handlers,
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
