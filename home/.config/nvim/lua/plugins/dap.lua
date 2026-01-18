return {
	"mfussenegger/nvim-dap",
	lazy = true,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"TheLeoP/powershell.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{ "<leader>df", function() require("dapui").float_element(nil, { enter = true }) end, desc = "DAP float element" },
		{ "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
		{ "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
		{ "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
		{ "<F12>", function() require("dap").step_out() end, desc = "Debug: Step out" },
		{ "<leader>bt", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
		{ "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
		{ "<leader>lp", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Debug: Set log point" },
		{ "<leader>dt", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
		{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Debug: Evaluate" },
		{ "<S-F5>", function()
			local cwd = vim.fn.getcwd()
			local go_project = vim.fn.glob(cwd .. "/go.mod") ~= ""
			local dotnet_project = vim.fn.glob(cwd .. "/*.sln") ~= "" or vim.fn.glob(cwd .. "/*.csproj") ~= ""
			vim.cmd("split")
			vim.cmd("wincmd w")
			if go_project then
				vim.cmd("term go run .")
			elseif dotnet_project then
				vim.cmd("term dotnet run .")
			else
				print("Not a Go or .NET project.")
			end
		end, desc = "Debug: Run project in terminal" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("nvim-dap-virtual-text").setup()
		dap.set_log_level("WARN")

		require("config.dap.zig")
		require("config.dap.cs")

		require("dap-go").setup()
		require("dapui").setup()

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)

		require("powershell").setup({
			bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
		dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
	end,
}
