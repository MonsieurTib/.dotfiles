return {
  "MonsieurTib/neonuget",
  cmd = "NuGet",
  config = function()
    require("neonuget").setup({})
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
--return {}
