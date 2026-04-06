return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" }, -- Trigger linting on events
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        go = { "golangcilint" },
        lua = { "luacheck" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        -- python = { "flake8" },
        -- sh = { "shellcheck" },
      }

      -- golangci-lint finds its config via its own directory traversal;
      -- do not inject --config here as it breaks multi-project workflows.

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      -- golangci-lint is slow: only trigger on save, not InsertLeave
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        group = lint_augroup,
        pattern = "*.go",
        callback = function()
          if vim.fn.executable("golangci-lint") == 1 then
            lint.try_lint()
          end
        end,
      })

      -- Fast linters: trigger on InsertLeave too
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          local ft = vim.bo.filetype
          if ft ~= "go" then
            lint.try_lint()
          end
        end,
      })

      -- Add keymap for manual linting
      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current buffer" })
    end,
  },
}
