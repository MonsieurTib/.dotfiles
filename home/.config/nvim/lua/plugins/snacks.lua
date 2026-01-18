return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		indent = {
			enabled = true,
			char = "│",
			blank = " ",
			scope = {
				enabled = true,
				char = "│",
			},
		},
		lazygit = {},
		-- Replaces gitsigns.nvim
		git = { enabled = true },
		gitbrowse = { enabled = true },
		-- Replaces telescope.nvim
		picker = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				header = [[
       ████ ██████           █████      ██
      ███████████             █████
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████]],
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#393F5D" })
	end,
	keys = {
		{
			"<leader>lg",
			function()
				Snacks.lazygit.open()
			end,
			desc = "[L]azy [G]it",
		},

		-- Git keymaps (replacing gitsigns)
		{
			"<leader>gh",
			function()
				Snacks.git.blame_line()
			end,
			desc = "[G]it blame line",
		},
		{
			"<leader>gb",
			function()
				Snacks.gitbrowse.open()
			end,
			desc = "[G]it [B]rowse",
		},
		-- Picker keymaps (replacing telescope)
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help tags",
		},
		{
			"<leader>fo",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent files",
		},
	},
}
