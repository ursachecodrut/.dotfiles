return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	dependencies = {
		-- polls macOS appearance and sets 'background'; works inside tmux
		{ "f-person/auto-dark-mode.nvim", opts = {} },
	},
	config = function()
		require("catppuccin").setup({
			flavour = "auto", -- latte when background=light, mocha when dark
			background = { light = "latte", dark = "mocha" },
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
