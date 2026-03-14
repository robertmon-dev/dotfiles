return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    opts = function(_, opts)
      opts.endwise = { enable = true }
      opts.indent = { enable = true, disable = { "yaml", "ruby" } }

      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "bash",
          "fish",
          "hyprlang",
          "embedded_template",
          "go",
          "html",
          "javascript",
          "ruby",
          "tsx",
          "typescript",
          "yaml",
          "vimdoc",
        })
      end
    end,
  },
}
