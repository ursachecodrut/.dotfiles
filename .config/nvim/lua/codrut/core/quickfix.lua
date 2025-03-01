local opts = { noremap = true, silent = true }

-- Function to clear the quickfix list
local function clear_quickfix_list()
	vim.fn.setqflist({})
	print("Quickfix list cleared!")
end

-- Function to delete an item from the quickfix list
local function delete_quickfix_item()
	local quickfix_list = vim.fn.getqflist()
	local current_line = vim.fn.line(".") -- Line numbers are 1-indexed
	table.remove(quickfix_list, current_line)
	vim.fn.setqflist(quickfix_list, "r")
	print("Deleted item at line " .. current_line)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "dd", delete_quickfix_item, {
			buffer = true, -- Set only for the current buffer
			desc = "Delete quickfix item",
		})
	end,
})

vim.keymap.set("n", "<leader>cq", clear_quickfix_list, { desc = "Clear quickfix list" })
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", opts) -- open quickfix
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", opts) -- close quickfix
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>", opts) -- go to next quickfix
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<CR>", opts) -- go to previous quickfix
