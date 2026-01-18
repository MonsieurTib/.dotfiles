return {
  cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/elixir-ls") },
  filetypes = { "elixir", "eelixir", "heex" },
  root_markers = { "mix.exs", ".git" },
  settings = {
    elixirLS = {
      -- Enable dialyzer for additional type checking
      dialyzerEnabled = true,
      -- Enable formatting
      mixEnv = "dev",
      -- Enable suggestions
      suggestSpecs = true,
      -- Additional settings
      enableTestLenses = true,
      mixTarget = "host",
      projectDir = ".",
      -- Fetch dependencies automatically
      fetchDeps = false,
    },
  },
}
