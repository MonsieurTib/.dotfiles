-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false,
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin-mocha")
-- 	end,
-- },
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,  -- load immediately
    priority = 1000, -- make sure it loads before other plugins
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme for faster startup
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- set to true if you want transparent background
        dimInactive = false,
        terminalColors = true,
        theme = "wave", -- "wave", "dragon", "lotus"
        background = { -- map the value of 'background' option to a theme
          dark = "wave",
          light = "lotus",
        },
      })

      -- Load the colorscheme
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
