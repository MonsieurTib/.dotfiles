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
        go = { "goimports", "gofmt", lsp_format = "fallback" },
        terraform = { "terraform_fmt" },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        cs = { "csharpier" },
      },
      formatters = {
        prettier = {
          prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
        },
        prettierd = {
          prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
        },
        csharpier = {
          command = vim.fn.expand("~/.dotnet/tools/csharpier"),
          args = { "--write-stdout" },
          stdin = true,
        },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    -- Manual format keymap
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({ async = false, lsp_format = "fallback" })
    end, { desc = "Format buffer" })

    -- Format on insert leave for modified files
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.bo.filetype ~= "gitcommit" then
          conform.format({ async = false, lsp_format = "fallback" })
        end
      end,
      desc = "Auto-format on insert leave",
    })
  end,
}
