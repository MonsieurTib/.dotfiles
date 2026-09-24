-- FILETYPES (what :set ft? reports), not parser names
local filetypes = {
	"lua",
	"javascript",
	"typescript",
	"typescriptreact",
	"javascriptreact",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"terraform",
	"hcl",
	"terraform-vars",
	"cs",
	"rust",
	"toml",
	"zig",
	"html",
	"css",
	"json",
	"yaml",
	"dockerfile",
	"bash",
}

-- PARSERS (what treesitter compiles)
local parsers = {
	"lua",
	"javascript",
	"typescript",
	"tsx",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"terraform",
	"hcl",
	"c_sharp",
	"rust",
	"toml",
	"zig",
	"html",
	"css",
	"json",
	"yaml",
	"dockerfile",
	"bash",
	"markdown",
	"markdown_inline",
	"query",
	"vim",
	"vimdoc",
	"diff",
	"gitcommit",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup({})

		-- main branch never auto-installs; only fetch what's missing (no-op once warm)
		local installed = ts.get_installed("parsers")
		local missing = vim.tbl_filter(function(p)
			return not vim.tbl_contains(installed, p)
		end, parsers)
		if #missing > 0 then
			ts.install(missing)
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("ts_start", { clear = true }),
			pattern = filetypes,
			callback = function(ev)
				if vim.api.nvim_buf_line_count(ev.buf) > 50000 then
					return
				end
				if not pcall(vim.treesitter.start, ev.buf) then
					return
				end
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldlevel = 99
			end,
		})
	end,
}
