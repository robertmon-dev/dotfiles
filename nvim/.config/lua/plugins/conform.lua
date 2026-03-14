return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      eruby = { "htmlbeautifier" },
      ruby = { "standardrb" },
      markdown = { "markdownlint" },
      yaml = { "yamlfix" },
      javascript = { { "prettierd", "prettier", stop_after_first = true } },
      typescript = { { "prettierd", "prettier", stop_after_first = true } },
      json = { "jq" },
    },
  },
}
