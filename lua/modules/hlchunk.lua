require("hlchunk").setup({
  chunk = {
    chars = {
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "┌",
      left_bottom = "└",
      right_arrow = "─",
    },
    style = "#00ffff",
  },
  line_num = {
    style = "#806d9c",
  },
  indent = {
    chars = {
      "│",
    },
    exclude_filetype = {
      "help",
      "plugin",
      "lazy",
      "alpha"
    },
  },
  blank = {
    enable = false,
    -- chars = {
    --   " ",
    -- },
    -- style = {
    --   { bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
    --   { bg = "",                                                                         fg = "" },
    -- },
  },
})
