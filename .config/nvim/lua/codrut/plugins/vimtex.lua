return {
	"lervag/vimtex",
	lazy = true,
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_view_general_viewer = "okular"
		vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"

		vim.g.vimtex_compiler_method = "latexmk"
	end,
}
