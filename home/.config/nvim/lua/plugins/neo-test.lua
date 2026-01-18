return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		"nvim-neotest/neotest-go",
	},
	keys = {
		{ "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
		{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
		{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
		{ "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open test output" },
		{ "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
	},
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)
		require("neotest").setup({
			adapters = {
				require("neotest-go")({
					experimental = {
						test_table = true,
					},
				}),
			},
		})
	end,
}
