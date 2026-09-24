return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        go = { lsp_format = "prefer" }, -- gopls handles imports + gofumpt
        terraform = { "terraform_fmt" },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        cs = { "csharpier" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
    })

    -- Manual format keymap
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({ async = false, lsp_format = "fallback" })
    end, { desc = "Format buffer" })
  end,
}
