return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- nav_hunk supersedes the deprecated next_hunk/prev_hunk
			map("n", "]h", function()
				gs.nav_hunk("next")
			end, "Next git hunk")
			map("n", "[h", function()
				gs.nav_hunk("prev")
			end, "Prev git hunk")

			map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage hunk")
			map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>hd", gs.diffthis, "Diff this")
		end,
	},
}
