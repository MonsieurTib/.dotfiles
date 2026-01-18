return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>ef", "<CMD>Neotree filesystem focus reveal left<CR>", { desc = "Explorer Focus" })
		vim.keymap.set("n", "<leader>et", "<CMD>Neotree filesystem toggle reveal left<CR>", { desc = "Explorer Toggle" })
	end,
}
