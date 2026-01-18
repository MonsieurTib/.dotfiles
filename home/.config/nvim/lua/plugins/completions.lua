return {
	-- {
	--   "github/copilot.vim",
	--   config = function()
	--     vim.g.copilot_enabled = false
	--     vim.g.copilot_no_tab_map = true
	--     vim.g.copilot_assume_mapped = true
	--
	--     vim.keymap.set("i", "<C-j>", "copilot#Next()", { silent = true, expr = true, replace_keycodes = false })
	--     vim.keymap.set("i", "<C-k>", "copilot#Previous()", { silent = true, expr = true, replace_keycodes = false })
	--     vim.keymap.set("i", "<C-h>", "copilot#Dismiss()", { silent = true, expr = true, replace_keycodes = false })
	--     vim.keymap.set("i", "<C-l>", 'copilot#Accept("")', { silent = true, expr = true, replace_keycodes = false })
	--   end,
	-- },
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
		}, -- event = "InsertEnter",
		version = "*",
		config = function()
			vim.cmd("highlight Pmenu guibg=none")
			vim.cmd("highlight PmenuExtra guibg=none")
			vim.cmd("highlight FloatBorder guibg=none")
			vim.cmd("highlight NormalFloat guibg=none")

			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				signature = { enabled = true },
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "normal",
				},
				sources = {
					per_filetype = {
						codecompanion = { "codecompanion" },
					},
					default = { "snippets", "lsp", "path", "buffer" },
					providers = {
						snippets = {
							score_offset = 10,
							should_show_items = function(ctx)
								-- Hide snippets when completion was triggered by a trigger character
								-- e.g. in Lua: ., ", '
								return ctx.trigger.initial_kind ~= "trigger_character"
							end,
						},
						lsp = { score_offset = 0 },
					},
				},
				keymap = {
					-- Accept completion
					["<CR>"] = { "accept", "fallback" },

					-- Navigation
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
					["<C-u>"] = { "scroll_documentation_up", "fallback" },
					["<C-d>"] = { "scroll_documentation_down", "fallback" },

					-- Show completion menu
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },

					-- Snippet navigation
					["<C-n>"] = { "snippet_forward", "fallback" },
					["<C-p>"] = { "snippet_backward", "fallback" },

					-- Disable some keys
					["<C-f>"] = {},
				},
				cmdline = {
					enabled = false,
					completion = { menu = { auto_show = true } },
					keymap = {
						["<CR>"] = { "accept_and_enter", "fallback" },
					},
				},
				completion = {
					menu = {
						border = "single",
						scrolloff = 1,
						scrollbar = false,
						draw = {
							columns = {
								{ "kind_icon" },
								{ "label", "label_description", gap = 1 },
								{ "kind" },
								{ "source_name" },
							},
						},
					},
					list = {
						selection = {
							preselect = true,
							auto_insert = false,
						},
					},
					documentation = {
						window = {
							border = "single",
							scrollbar = false,
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
						auto_show = true,
						auto_show_delay_ms = 500,
					},
				},
				fuzzy = {
					sorts = {
						"exact", -- Default sorts
						"score",
						"sort_text",
					},
				},
			})

			vim.defer_fn(function() require("luasnip.loaders.from_vscode").lazy_load() end, 50)
		end,
	},
}
