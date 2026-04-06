return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>ef", "<CMD>Neotree filesystem focus reveal left<CR>", desc = "Explorer Focus" },
		{ "<leader>et", "<CMD>Neotree filesystem toggle reveal left<CR>", desc = "Explorer Toggle" },
	},
}
