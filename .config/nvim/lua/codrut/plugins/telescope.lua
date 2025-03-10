return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = "󰣉 ",
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<A-j>"] = actions.preview_scrolling_down,
						["<A-k>"] = actions.preview_scrolling_up,
					},
				},
				file_ignore_patterns = { "node_modules", ".git" },
			},
			extensions = {
				fzf = {},
			},
			pickers = {
				buffers = {
					theme = "ivy",
					sort_lastused = true,
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
						n = {
							["<c-d>"] = actions.delete_buffer,
						},
					},
				},
				find_files = {
					hidden = true,
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
					file_ignore_patterns = { "node_modules", ".git", ".venv" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				grep_string = {
					theme = "ivy",
				},
				oldfiles = {
					theme = "ivy",
				},
				lsp_references = {
					theme = "ivy",
				},
				lsp_definitions = {
					theme = "ivy",
				},
				lsp_implementations = {
					theme = "ivy",
				},
				lsp_type_definitions = {
					theme = "ivy",
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Fuzzy find help tags" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Fuzzy find buffers" })

		require("codrut.plugins.telescope.multigrep").setup()
	end,
}
