local languages = {
	"lua",
	"javascript",
	"go",
	"terraform",
	"hcl",
	"zig",
	"angular",
	"typescript",
	"html",
	"json",
	"dockerfile",
	"c_sharp",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({})
		require("nvim-treesitter").install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldlevel = 99
			end,
		})
	end,
}
