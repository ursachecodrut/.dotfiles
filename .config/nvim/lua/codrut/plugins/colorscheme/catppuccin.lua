return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = true,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			term_colors = true,
		})
	end,
}
