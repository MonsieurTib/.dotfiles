return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"lua-language-server", -- lua_ls
					"gopls", -- gopls
					"terraform-ls", -- terraformls
					"zls", -- zls
					"angular-language-server", -- angularls
					"typescript-language-server", -- ts_ls
					"css-lsp", -- cssls
					"html-lsp", -- html
					"dockerfile-language-server", -- dockerls
					-- Formatters and tools
					"prettier",
					"eslint_d",
					"stylua",
					"delve",
					"golangci-lint",
					"elixir-ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers_from_lsp_folder = {
				"lua_ls",
				"gopls",
				"ts_ls",
				"terraformls",
				"zls",
				"html",
				"cssls",
				"angularls",
				"dockerls",
				"roslyn",
				"elixir_ls",
			}

			for _, server in ipairs(servers_from_lsp_folder) do
				-- Load the config from lsp/ directory
				local config_ok, server_config = pcall(require, "lsp." .. server)
				if config_ok then
					-- Special handling for roslyn (uses separate plugin)
					if server == "roslyn" then
					-- Roslyn is handled by the roslyn.nvim plugin below
					-- Just load the config for reference/future use
					else
						server_config.capabilities = capabilities
						vim.lsp.config(server, server_config)
						vim.lsp.enable(server)
					end
				else
					-- Fallback if config file doesn't exist (except for roslyn)
					if server ~= "roslyn" then
						vim.lsp.config(server, { capabilities = capabilities })
						vim.lsp.enable(server)
					end
				end
			end

			-- LSP Keymaps and diagnostics
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local bufnr = event.buf

					local function map(mode, lhs, rhs, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, lhs, rhs, opts)
					end

					map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
					map("n", "<leader>re", vim.lsp.buf.rename, { desc = "Rename" })
					map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
					map("n", "<leader>it", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
					end, { desc = "Toggle Inlay Hints" })

					-- Auto-enable inlay hints for specific file types
					local ft = vim.bo[bufnr].filetype
					if vim.tbl_contains({ "go", "cs" }, ft) and vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end

					-- Use Snacks.picker for LSP functions
					map("n", "<leader>gd", function()
						Snacks.picker.lsp_definitions()
					end, { desc = "[G]oto [D]efinition" })
					map("n", "<leader>gr", function()
						Snacks.picker.lsp_references()
					end, { desc = "[G]oto [R]eferences" })
					map("n", "<leader>gi", function()
						Snacks.picker.lsp_implementations()
					end, { desc = "[G]oto [I]mplementation" })
					map("n", "<leader>gt", function()
						Snacks.picker.lsp_type_definitions()
					end, { desc = "[G]oto [T]ype definition" })
					map("n", "<leader>ds", function()
						Snacks.picker.lsp_symbols()
					end, { desc = "[D]ocument [S]ymbols" })
					map("n", "<leader>ws", function()
						Snacks.picker.lsp_workspace_symbols()
					end, { desc = "[W]orkspace [S]ymbols" })
				end,
			})

			-- Diagnostic configuration
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		config = function()
			-- Load roslyn config from lsp/ directory for consistency
			local config_ok, roslyn_config = pcall(require, "lsp.roslyn")

			-- Get blink.cmp capabilities for completion support
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure roslyn through vim.lsp.config (the correct way per documentation)
			if config_ok and roslyn_config.settings then
				vim.lsp.config("roslyn", {
					settings = roslyn_config.settings,
					capabilities = capabilities,
				})
			else
				vim.lsp.config("roslyn", {
					capabilities = capabilities,
				})
			end

			require("roslyn").setup({
				-- Plugin-specific settings only
			})
		end,
	},
}
