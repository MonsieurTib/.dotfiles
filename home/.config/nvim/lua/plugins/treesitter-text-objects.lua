return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local tsto = require("nvim-treesitter-textobjects")
		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		tsto.setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		-- Select keymaps
		local select_maps = {
			["a="] = { "@assignment.outer", "Select outer part of an assignment" },
			["i="] = { "@assignment.inner", "Select inner part of an assignment" },
			["l="] = { "@assignment.lhs", "Select left hand side of an assignment" },
			["r="] = { "@assignment.rhs", "Select right hand side of an assignment" },
			["a:"] = { "@property.outer", "Select outer part of an object property" },
			["i:"] = { "@property.inner", "Select inner part of an object property" },
			["l:"] = { "@property.lhs", "Select left part of an object property" },
			["r:"] = { "@property.rhs", "Select right part of an object property" },
			["aa"] = { "@parameter.outer", "Select outer part of a parameter/argument" },
			["ia"] = { "@parameter.inner", "Select inner part of a parameter/argument" },
			["ai"] = { "@conditional.outer", "Select outer part of a conditional" },
			["ii"] = { "@conditional.inner", "Select inner part of a conditional" },
			["al"] = { "@loop.outer", "Select outer part of a loop" },
			["il"] = { "@loop.inner", "Select inner part of a loop" },
			["af"] = { "@call.outer", "Select outer part of a function call" },
			["if"] = { "@call.inner", "Select inner part of a function call" },
			["am"] = { "@function.outer", "Select outer part of a method/function definition" },
			["im"] = { "@function.inner", "Select inner part of a method/function definition" },
			["ac"] = { "@class.outer", "Select outer part of a class" },
			["ic"] = { "@class.inner", "Select inner part of a class" },
			["ab"] = { "@block.outer", "Select outer part of a block" },
			["ib"] = { "@block.inner", "Select inner part of a block" },
		}

		for key, val in pairs(select_maps) do
			vim.keymap.set({ "x", "o" }, key, function()
				select.select_textobject(val[1], "textobjects")
			end, { desc = val[2] })
		end

		-- Swap keymaps
		local swap_next_maps = {
			["<leader>na"] = "@parameter.inner",
			["<leader>n:"] = "@property.outer",
			["<leader>nm"] = "@function.outer",
		}
		local swap_prev_maps = {
			["<leader>pa"] = "@parameter.inner",
			["<leader>p:"] = "@property.outer",
			["<leader>pm"] = "@function.outer",
		}

		for key, query in pairs(swap_next_maps) do
			vim.keymap.set("n", key, function()
				swap.swap_next(query)
			end)
		end
		for key, query in pairs(swap_prev_maps) do
			vim.keymap.set("n", key, function()
				swap.swap_previous(query)
			end)
		end

		-- Move keymaps: goto_next_start
		local next_start_maps = {
			["]f"] = { "@call.outer", "textobjects", "Next function call start" },
			["<leader>j"] = { "@function.outer", "textobjects", "Next method/function def start" },
			["]c"] = { "@class.outer", "textobjects", "Next class start" },
			["]i"] = { "@conditional.outer", "textobjects", "Next conditional start" },
			["]l"] = { "@loop.outer", "textobjects", "Next loop start" },
			["]s"] = { "@local.scope", "locals", "Next scope" },
			["]z"] = { "@fold", "folds", "Next fold" },
		}
		for key, val in pairs(next_start_maps) do
			vim.keymap.set({ "n", "x", "o" }, key, function()
				move.goto_next_start(val[1], val[2])
			end, { desc = val[3] })
		end

		-- Move keymaps: goto_next_end
		local next_end_maps = {
			["]F"] = { "@call.outer", "textobjects", "Next function call end" },
			["]M"] = { "@function.outer", "textobjects", "Next method/function def end" },
			["]C"] = { "@class.outer", "textobjects", "Next class end" },
			["]I"] = { "@conditional.outer", "textobjects", "Next conditional end" },
			["]L"] = { "@loop.outer", "textobjects", "Next loop end" },
		}
		for key, val in pairs(next_end_maps) do
			vim.keymap.set({ "n", "x", "o" }, key, function()
				move.goto_next_end(val[1], val[2])
			end, { desc = val[3] })
		end

		-- Move keymaps: goto_previous_start
		local prev_start_maps = {
			["[f"] = { "@call.outer", "textobjects", "Prev function call start" },
			["<leader>k"] = { "@function.outer", "textobjects", "Prev method/function def start" },
			["[c"] = { "@class.outer", "textobjects", "Prev class start" },
			["[i"] = { "@conditional.outer", "textobjects", "Prev conditional start" },
			["[l"] = { "@loop.outer", "textobjects", "Prev loop start" },
		}
		for key, val in pairs(prev_start_maps) do
			vim.keymap.set({ "n", "x", "o" }, key, function()
				move.goto_previous_start(val[1], val[2])
			end, { desc = val[3] })
		end

		-- Move keymaps: goto_previous_end
		local prev_end_maps = {
			["[F"] = { "@call.outer", "textobjects", "Prev function call end" },
			["[M"] = { "@function.outer", "textobjects", "Prev method/function def end" },
			["[C"] = { "@class.outer", "textobjects", "Prev class end" },
			["[I"] = { "@conditional.outer", "textobjects", "Prev conditional end" },
			["[L"] = { "@loop.outer", "textobjects", "Prev loop end" },
		}
		for key, val in pairs(prev_end_maps) do
			vim.keymap.set({ "n", "x", "o" }, key, function()
				move.goto_previous_end(val[1], val[2])
			end, { desc = val[3] })
		end

		-- Repeatable moves with ; and ,
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Builtin f, F, t, T repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
