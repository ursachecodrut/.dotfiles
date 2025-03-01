return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvimdev/lspsaga.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local lspconfig = require("lspconfig")

		local keymap = vim.keymap -- for conciseness
		local opts = { noremap = true, silent = true }

		---@diagnostic disable-next-line: unused-local
		local on_attach = function(_client, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line

			opts.desc = "Show cursor diagnostics"
			keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>sb", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local language_servers = {
			"html",
			"ts_ls",
			"cssls",
			"tailwindcss",
			"emmet_ls",
			"elixirls",
			"terraformls",
			"bashls",
			"dockerls",
			"hls",
			"helm_ls",
			"ruff",
			"lua_ls",
		}

		local base_config = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- List of servers with custom configurations
		local custom_servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
			helm_ls = {
				settings = {
					["helm-ls"] = {
						yamlls = {
							enable = true,
							path = "yaml-language-server",
							logLevel = "debug",
							config = {
								schemas = {
									["/Users/cursache/.config/nvim/schemas/rollout.schema.json"] = "k8s/helm/**/values.yaml",
								},
							},
						},
					},
				},
			},
			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
					"heex",
					"eex",
				},
			},
		}

		-- Iterate over the language servers and set them up
		for _, server in ipairs(language_servers) do
			local config = base_config
			if custom_servers[server] then
				config = vim.tbl_extend("force", base_config, custom_servers[server])
			end
			lspconfig[server].setup(config)
		end
	end,
}
