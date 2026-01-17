return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      -- C# / .NET
      cs = { "csharpier" },
      -- Go
      go = { "goimports", "gofumpt" },
      -- Rust
      rust = { "rustfmt", lsp_format = "fallback" },
      -- C/C++
      c = { "clang-format" },
      cpp = { "clang-format" },
      -- Java
      java = { "google-java-format" },
      -- Python
      python = { "ruff_format" },
      -- Web & Configs
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      toml = { "taplo" },
      -- Lua
      lua = { "stylua" },
      -- Shell Script
      sh = { "shfmt" },
      -- Fallback
      ["_"] = { "trim_whitespace" },
    },

    -- NOTIFICATIONS
    notify_on_error = true,
    notify_no_formatters = true,
  },
}
