vim.schedule(function()
	vim.opt_local.tabstop = 4
	vim.opt_local.shiftwidth = 4
	vim.opt_local.softtabstop = 4
	vim.opt_local.expandtab = true
end)

-- Auto-move semicolon outside empty parentheses (like JetBrains Rider)
vim.keymap.set("i", ";", function()
	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local before = line:sub(col - 1, col - 1)
	local after = line:sub(col, col)
	-- Only trigger for empty parentheses: (|)
	if before == "(" and after == ")" then
		return "<Right>;"
	end
	return ";"
end, { expr = true, buffer = true })
