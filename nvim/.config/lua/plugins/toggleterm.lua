return {
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    build = ":ToggleTerm",
    keys = {
      {
        "<leader>x",
        function()
          local term = require("toggleterm.terminal").Terminal:new({
            direction = "float",
            float_opts = {
              border = "rounded",
              width = 100,
              height = vim.o.lines - 4,
              col = vim.o.columns - 102,
              row = 1,
              winblend = 3,
              highlights = {
                border = "Normal",
                background = "Normal",
              },
            },
            dir = vim.fn.expand("%:p:h"),
          })
          term:toggle()
        end,
        desc = "Toggle vertical terminal (right)",
      },
      {
        "<leader>z",
        function()
          local term = require("toggleterm.terminal").Terminal:new({
            direction = "float",
            float_opts = {
              border = "rounded",
              width = vim.o.columns - 4,
              height = 30,
              col = 2,
              row = vim.o.lines - 32,
              winblend = 3,
              highlights = {
                border = "Normal",
                background = "Normal",
              },
            },
            dir = vim.fn.expand("%:p:h"),
          })
          term:toggle()
        end,
        desc = "Toggle horizontal terminal (bottom)",
      },
    },
    opts = {
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
      size = 20,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
  },
}
