vim.g.mapleader = " "

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true

-- Better search
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Unless you use uppercase
vim.opt.hlsearch = true -- Highlight all matches
vim.opt.incsearch = true -- Show matches as you type

--vim.opt.relativenumber = true -- Relative line numbers for easy jumps
vim.opt.signcolumn = "yes" -- Always show signcolumn (no layout shift)
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.undofile = true -- Persistent undo history
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
--vim.opt.cursorline = true -- Highlight current line

require("config.lazy")

local keymap = vim.keymap
keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Language-specific indentation settings
vim.api.nvim_create_augroup("FileTypeIndentation", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "FileTypeIndentation",
	pattern = { "python", "java", "c", "cpp", "php", "cs" },
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "FileTypeIndentation",
	pattern = "go",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = false -- Go uses tabs
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "FileTypeIndentation",
	pattern = {
		"javascript",
		"typescript",
		"json",
		"yaml",
		"yml",
		"html",
		"css",
		"scss",
		"lua",
		"vim",
		"terraform",
		"hcl",
	},
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.expandtab = true
	end,
})
