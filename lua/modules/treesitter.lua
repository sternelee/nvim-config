local disableTsOrLsp = function(lang, bufnr)
  local lcount = vim.api.nvim_buf_line_count(bufnr)
  local bytes = vim.api.nvim_buf_get_offset(bufnr, lcount)
  return bytes / lcount > 500
end

--nvim treesitter 编辑大文件卡顿时最好关闭 highlight, rainbow, autotag
require("nvim-treesitter.configs").setup({
  -- parser_install_dir = "~/.local/share/nvim/parsers",
  ensure_installed = {"vue", "html", "javascript", "typescript", "scss", "json", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash", "http", "dot", "regex", "markdown", "markdown_inline"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = disableTsOrLsp,
  },
  rainbow = {
    enable = true,
    -- query = "rainbow-parens",
    -- strategy = require("ts-rainbow.strategy.global"),
  },
  autotag = {
    enable = true,
    -- disable = disableTsOrLsp,
  },
  indent = {
    enable = true,
    -- disable = disableTsOrLsp,
  },
  incremental_selection = {
    enable = false,
  },
  context_commentstring = {
    enable = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,       -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
  },
})
-- vim.opt.runtimepath:append("~/.local/share/nvim/parsers")
