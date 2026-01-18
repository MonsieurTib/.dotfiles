vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false

-- Auto-expand blocks: typing { at end of line after block keywords
vim.keymap.set("i", "{", function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  local before = line:sub(1, col - 1)
  local after = vim.fn.trim(line:sub(col))
  -- Only expand at end of line after Go block keywords
  local keywords = { "if", "else", "for", "func", "switch", "select", "case", "default", "defer", "go" }
  local has_keyword = false
  for _, kw in ipairs(keywords) do
    if before:match("%f[%w]" .. kw .. "%f[%W]") or before:match("^%s*" .. kw .. "%s") then
      has_keyword = true
      break
    end
  end
  if after == "" and has_keyword then
    return "{<CR>}<Esc>O"
  end
  -- Manually handle auto-pair since we override mini.pairs
  return "{}<Left>"
end, { expr = true, buffer = true })
