local cmd = vim.cmd
local g = vim.g
local remap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

g.mapleader = " " --leader
g.maplocalleader = ","

vim.o.guifont = "OperatorMono Nerd Font:h18"

g.neovide_scale_factor = 1.0
g.neovide_input_macos_alt_is_meta = 1
g.neovide_input_use_logo = 1
g.neovide_remember_window_size = 1
g.neovide_confirm_quit = 1
g.neovide_hide_mouse_when_typing = 0

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/glepnir/nvim-lua-guide-zh
-- https://github.com/neovim/neovim/wiki/Related-projects#Plugins
-- https://github.com/yutkat/my-neovim-pluginlist
-- using :source % or :luafile %
-- log: nvim -V9myNvim.log
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup({
  { "nvim-lua/plenary.nvim",           "nvim-lua/popup.nvim", event = "VeryLazy" },
  {
    "LunarVim/bigfile.nvim",
    config = function()
      require("bigfile").config({
        filesize = 1,
        features = {
          "treesitter",
          "lsp",
          "indent_blankline",
          "syntax",
          "filetype",
        },
      })
    end,
  },
  { "antoinemadec/FixCursorHold.nvim", event = "BufNewFile" },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 1000,
        background_colour = "#000000",
        stages = "fade",
      })
      vim.notify = notify
    end,
  },
  -- 状态栏
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        animation = true,
        auto_hide = true,
        icons = { buffer_index = true, filetype = { enabled = true } },
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({ color_icons = true, default = true })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = {
      "linrongbin16/lsp-progress.nvim",
    },
    config = function()
      require("modules.lualine")
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require("modules.nvim-tree")
    end,
  },
  { "goolord/alpha-nvim", event = "VimEnter" },
  -- git相关
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter", "LazyGitFilterCurrentFile" },
  },
  {
    "akinsho/git-conflict.nvim",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
    },
    config = function()
      require("git-conflict").setup()
    end,
  },
  { "rbong/vim-flog",     cmd = { "Flog" } },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("modules.gitsigns")
    end,
  },
  -- 语法高亮
  {
    "kevinhwang91/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("modules.treesitter")
    end,
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
    config = function()
      require("twilight"):setup()
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    config = function()
      require("modules.colorizer")
    end,
  },   -- 色值高亮
  -- theme 主题 -- https://vimcolorschemes.com/
  {
    "maxmx03/fluoromachine.nvim",
    config = function()
      local fm = require("fluoromachine")
      fm.setup({
        glow = true,
        brightness = 0.1,
        theme = "retrowave",
        transparent = "full",
      })
      -- vim.cmd.colorscheme("fluoromachine")
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    event = "VeryLazy",
    dependencies = {
      -- "lunarvim/synthwave84.nvim",
      -- "LunarVim/horizon.nvim",
      "RRethy/nvim-base16",
      -- "LunarVim/darkplus.nvim",
      -- "glepnir/porcelain.nvim",
      "sainnhe/gruvbox-material",
    },
  },
  -- 显示导航线
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("modules.indent_blankline")
  --   end,
  -- },   -- 对齐线
  {
    "shellRaining/hlchunk.nvim",
    event = "VeryLazy",
    config = function()
      require("modules.hlchunk")
    end,
  },
  { "mg979/vim-visual-multi",    event = "VeryLazy" },
  { "terryma/vim-expand-region", event = "VeryLazy" },
  { "matze/vim-move",            event = "BufRead" },
  {
    "phaazon/hop.nvim",
    cmd = { "HopWord", "HopLine", "HopPattern" },
    config = function()
      require("hop"):setup()
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "leafOfTree/vim-project", cmd = { "Project", "ProjectList", "ProjectSearchFiles", "ProjectFindInFiles" } },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      -- "ahmedkhalf/project.nvim",
      -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-symbols.nvim",
      "aaronhallaert/advanced-git-search.nvim",
    },
    config = function()
      require("modules.telescope")
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    event = "VeryLazy",
    dependencies = {
      "renerocksai/calendar-vim",
      "mzlogin/vim-markdown-toc",
    },
    config = function()
      require("modules.telekasten")
    end,
  },   -- 日志管理
  -- 语法建议
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      -- "folke/neoconf.nvim",
      { "lvimuser/lsp-inlayhints.nvim", branch = "main" },
    },
    config = function()
      require("lsp/config")
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = {"BufReadPost"},
    branch = "main",
    config = function()
      require("modules.saga")
    end,
  },
  { "Bekaboo/dropbar.nvim",   event = "VeryLazy", opts = {} },
  {
    "Exafunction/codeium.vim",
    event = "VeryLazy",
    config = function()
      g.codeium_disable_bindings = 1
      -- g.codeium_manual = true
      keymap("i", "<C-k>", function()
        return vim.fn["codeium#Complete"]()
      end, { expr = true })       -- 都会自动触发，会卡
      keymap("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      keymap("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      keymap("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      keymap("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun" },
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "InsertEnter",
    config = function()
      require("lsp_lines").setup()
      keymap("", "<Leader>tp", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
    end,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    event = "VeryLazy",
    ft = { "typescript", "typescriptreact", "vue" },
    config = function()
      require("modules.typescript")
    end,
  },
  -- 语法提示
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      -- "lukas-reineke/cmp-under-comparator",
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("modules.luasnip")
        end,
      },
      -- "hrsh7th/cmp-cmdline",
      {
        "onsails/lspkind-nvim",
        config = function()
          require("lspkind").init()
        end,
      },
    },
    config = function()
      require("modules.cmp")
    end,
  },
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("refactoring").setup()
  --     require("telescope").load_extension("refactoring")
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    ft = "qf",
    event = "InsertEnter",
    config = function()
      require("trouble").setup()
    end,
  },
  { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "InsertEnter",
    config = function()
      require("modules.null-ls")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    cmd = "DapOpen",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("modules.dap")
    end,
  },
  -- rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    event = "InsertEnter",
    config = function()
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          runnables = { use_telescope = true },
          inlay_hints = { show_parameter_hints = true, auto = false },
          hover_actions = { auto_focus = true },
        },
      })
    end,
  },
  {
    "Saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    config = function()
      require("crates").setup()
    end,
  },
  {
    "David-Kunz/cmp-npm",
    event = "BufRead package.json",
    config = function()
      require("cmp-npm").setup({})
    end,
  },
  {
    "vuki656/package-info.nvim",
    event = "BufRead package.json",
    config = function()
      require("package-info").setup({ package_manager = "pnpm" })
    end,
  },
  {
    "NTBBloodbath/rest.nvim",
    ft = "http",
    config = function()
      require("rest-nvim").setup()
    end,
  },
  { "pechorin/any-jump.vim",          cmd = { "AnyJump", "AnyJumpVisual", "AnyJumpBack" } },
  {
    "rmagatti/goto-preview",
    ft = { "typescript", "javascript", "typescriptreact", "rust", "vue" },
    event = "VeryLazy",
    config = function()
      require("goto-preview").setup({})
    end,
  },
  -- {'napmn/react-extract.nvim', config = function() require('react-extract').setup() end} -- 重构react组件
  { "metakirby5/codi.vim",      cmd = { "Codi" } },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
  },
  -- { "jmbuhr/otter.nvim",        ft = "markdown", event = "VeryLazy", config = function()
  --   require("modules.otter")
  -- end},
  { "skywind3000/asyncrun.vim", cmd = "AsyncRun" },
  { "tpope/vim-dispatch",       cmd = { "Make", "Dispatch", "Focus", "Start" } },
  --- 方便操作
  {
    "nacro90/numb.nvim",
    event = "VeryLazy",
    config = function()
      require("numb").setup()
    end,
  },
  { "voldikss/vim-translator", cmd = { "Translate" } },   -- npm install fanyi -g 安装翻译
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "barrett-ruth/import-cost.nvim",
    event = "VeryLazy",
    build = "sh install.sh yarn",
    config = function()
      require("import-cost").setup({})
    end,
  },
  { "machakann/vim-sandwich",  event = "VeryLazy" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "utilyre/sentiment.nvim",
    event = "VeryLazy",
    name = "sentiment",
    version = "*",
    opts = {},
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("modules.marks")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },   -- 提示leader按键
  { "HiPhish/nvim-ts-rainbow2", event = "VeryLazy" },   -- 彩虹匹配
  { "windwp/nvim-ts-autotag",   event = "VeryLazy" },
  { "AndrewRadev/tagalong.vim", event = "VeryLazy" },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      require("modules.todo")
    end,
  },
  {
    "danymat/neogen",
    event = "VeryLazy",
    config = function()
      require("neogen").setup({ enabled = true })
    end,
  },   -- 方便写jsdoc注释
  { "ntpeters/vim-better-whitespace", event = "VeryLazy" },
  { "ThePrimeagen/vim-be-good",       cmd = "VimBeGood" },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
      require("spectre").setup()
    end,
  },   -- 全局搜索
  { "tpope/vim-repeat",         event = "VeryLazy" },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("modules.ufo")
    end,
  },   -- 折叠
  { "wakatime/vim-wakatime",    event = "VeryLazy" },
  { "gennaro-tedesco/nvim-jqx", cmd = { "JqxList", "JqxQuery" } },
  { "godlygeek/tabular",        event = "VeryLazy" }, -- 对齐方式
  {
    "ckolkey/ts-node-action",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter",
    },
    config = function()
      require("ts-node-action").setup({})
    end,
  },                                        -- 字符组合切换
  { "is0n/fm-nvim", event = "VeryLazy" },   -- 快速使用终端命令
  {
    "stevearc/dressing.nvim",
    event = "BufEnter",
    config = function()
      require("dressing").setup({
        input = {
          win_options = {
            winblend = 0,
          },
        },
      })
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     require("modules.noice")
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  -- },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "gelguy/wilder.nvim",
    event = "VeryLazy",
    config = function()
      require("modules.wilder")
    end,
  },
  {
    "cshuaimin/ssr.nvim",
    event = "VeryLazy",
    module = "ssr",
    config = function()
      require("ssr").setup({
        min_width = 50,
        min_height = 5,
        max_width = 120,
        max_height = 25,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_confirm = "<cr>",
          replace_all = "<leader><cr>",
        },
      })
    end,
  },
}, {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

autocmd("FileType", {
  pattern = {
    "lazy",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    keymap("n", "<Esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

--settings
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

local indent = 2
opt("o", "encoding", "utf-8")
opt("b", "expandtab", true)                      -- Use spaces instead of tabs
opt("b", "shiftwidth", indent)                   -- Size of an indent
opt("b", "smartindent", true)                    -- Insert indents automatically
opt("b", "tabstop", indent)                      -- Number of spaces tabs count for
opt("o", "completeopt", "menu,menuone,noselect") -- Completion options
opt("o", "pumheight", 10)                        -- Maximum number of items to show in the popup menu
opt("o", "hidden", true)                         -- Enable modified buffers in background
opt("o", "scrolloff", 3)                         -- Lines of context
opt("o", "shiftround", true)                     -- Round indent
opt("o", "sidescrolloff", 8)                     -- Columns of context
-- opt('o', 'ignorecase', true)
-- opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt("o", "splitbelow", true)         -- Put new windows below current
opt("o", "splitright", true)         -- Put new windows right of current
opt("o", "termguicolors", true)      -- True color support
opt("o", "clipboard", "unnamedplus") -- 与系统剪切板相通
opt("o", "pumblend", 25)
opt("o", "softtabstop", 2)
opt("o", "swapfile", false)
opt("o", "showmode", true)
opt("o", "background", "dark")
opt("o", "backup", false)
opt("o", "writebackup", false)
opt("w", "number", true) -- Print line number
opt("o", "lazyredraw", false)
opt("o", "signcolumn", "yes")
opt("o", "mouse", "a")
opt("o", "shortmess", "a")
opt("o", "cmdheight", 1)
opt("o", "wrap", false)
opt("o", "relativenumber", true)
opt("o", "hlsearch", true)
opt("o", "inccommand", "split")
opt("o", "smarttab", true)
opt("o", "incsearch", true)
opt("o", "list", true)
opt("o", "foldmethod", "indent")
-- opt('o', 'foldmethod', 'expr')
-- opt('o', 'foldexpr', 'nvim_treesitter#foldexpr()')
-- opt('o', 'foldcolumn', '1')
opt("o", "foldlevel", 99)
opt("o", "foldenable", true)
opt("o", "foldlevelstart", 99)
opt("o", "magic", true)
opt("o", "splitkeep", "screen")
-- opt('o', 'statuscolumn', '%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " ") : " " }')
opt("o", "sessionoptions", "buffers,help,tabpages")
-- opt("o", "fillchars", [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]])
opt("o", "breakindent", true)
opt("o", "lbr", true)
opt("o", "formatoptions", "l")
opt("o", "laststatus", 3)
opt("o", "cursorline", true)
opt("o", "cursorcolumn", true)
opt("o", "autowrite", true)
opt("o", "autoindent", true)
opt("o", "syntax", "on")
opt("o", "filetype", "on")
opt("o", "timeoutlen", 300)
opt("o", "showcmd", true)
opt("o", "history", 500)
opt("o", "ttimeoutlen", 10)
opt("o", "updatetime", 300)
opt("o", "scrolljump", 6)
opt("o", "undofile", true)
opt("o", "showtabline", 0)
-- opt('o', 'title', true)

--mappings
local function map(mode, lhs, rhs)
  local options = { noremap = true }
  remap(mode, lhs, rhs, options)
end

map("v", "x", "d")
map("v", "d", '"_d')
map("n", "P", '"0p')
map("v", "P", '"0p')
map("i", "jk", "<esc>") --jk to exit
map("c", "jk", "<C-C>")
map("n", ";f", "<C-f>")
map("n", ";b", "<C-b>")
map("n", ";", ":")  --semicolon to enter command mode
map("n", "j", "gj") --move by visual line not actual line
map("n", "k", "gk")
map("n", "q", "<cmd>q<CR>")
map("n", "gw", "<cmd>HopWord<CR>") --easymotion/hop
map("n", "gl", "<cmd>HopLine<CR>")
map("n", "g/", "<cmd>HopPattern<CR>")
map("n", "<leader>:", "<cmd>terminal<CR>")
map("n", "<leader>*", "<cmd>Telescope<CR>") --fuzzy
map("n", "<leader>f", "<cmd>Telescope find_files<CR>")
map("n", "<leader>b", "<cmd>Telescope buffers<CR>")
map("n", "<leader>m", "<cmd>Telescope marks<CR>")
-- map('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
map("n", "<leader>'", "<cmd>Telescope resume<CR>")
map("n", "gs", "<cmd>Telescope grep_string<CR>")
map("n", "fg", "<cmd>Telescope git_files<CR>")
map("n", "ft", "<cmd>Telescope treesitter<CR>")
map("n", "fc", "<cmd>Telescope commands<CR>")
map("n", "fe", "<cmd>Telescope file_browser<CR>")
map("n", "fp", "<cmd>Telescope projects<CR>")
map("n", "gq", "<cmd>Telescope diagnostics<CR>")
map("n", "gQ", '<cmd>lua require"telescope.builtin".symbols{ sources = {"emoji", "kaomoji", "gitmoji"} }<CR>')
map("n", "<leader>ns", '<cmd>lua require("package-info").show()<CR>')
map("n", "<leader>np", '<cmd>lua require("package-info").change_version()<CR>')
map("n", "<leader>ni", '<cmd>lua require("package-info").install()<CR>')
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
map("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>")
map("n", "<leader>tl", "<cmd>Twilight<CR>")
map("n", "<leader>tw", "<cmd>Translate<CR>")
map("n", "<leader>th", "<cmd>TSToggle highlight<CR>")
-- diffview
map("n", "<leader>td", "<cmd>DiffviewOpen<CR>")
map("n", "<leader>tD", "<cmd>DiffviewClose<CR>")
-- wincmd
map("n", "<c-k>", "<cmd>wincmd k<CR>") --ctrlhjkl to navigate splits
map("n", "<c-j>", "<cmd>wincmd j<CR>")
map("n", "<c-h>", "<cmd>wincmd h<CR>")
map("n", "<c-l>", "<cmd>wincmd l<CR>")
map("n", "<c-s>", "<cmd>w<CR>")
-- barbar
map("n", "<s-q>", "<cmd>BufferClose<CR>")
map("n", "<Tab>", "<cmd>BufferNext<CR>")
map("n", "<s-Tab>", "<cmd>BufferPrevious<CR>")
-- map('n', 'gb', '<cmd>BufferPick<CR>')
-- map('n', 'gp', '<cmd>bprevious<CR>')
-- map('n', 'gn', '<cmd>bnext<CR>')
-- map('n', '<leader>be', '<cmd>tabedit<CR>')
-- git
map("n", "<leader>ga", "<cmd>Git add %:p<CR>")
map("n", "<leader>go", "<cmd>Git add .<CR>")
map("n", "<leader>gm", "<cmd>Git commit<CR>")
map("n", "<leader>gs", "<cmd>Git status<CR>")
map("n", "<leader>gl", "<cmd>Git pull<CR>")
map("n", "<leader>gu", "<cmd>Git push<CR>")
map("n", "<leader>gr", "<cmd>Git reset --hard<CR>")
-- map('n', '<leader>gl', '<cmd>Git log<CR>')
map("n", "<leader><leader>g", "<cmd>LazyGit<CR>")

-- refactoring
map("v", "<leader>re", '<cmd>lua require("refactoring").refactor("Extract Function")<CR>')
map("v", "<leader>rf", '<cmd>lua require("refactoring").refactor("Extract Function To File")<CR>')
map("v", "<leader>rv", '<cmd>lua require("refactoring").refactor("Extract Variable")<CR>')
map("v", "<leader>ri", '<cmd>lua require("refactoring").refactor("Inline Variable")<CR>')
map("n", "<leader>ri", '<cmd>lua require("refactoring").refactor("Inline Variable")<CR>')
map("n", "<leader>rr", '<cmd><Esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>')

map("n", "<leader>j", "<cmd>AnyJump<CR>")
map("v", "<leader>j", "<cmd>AnyJumpVisual<CR>")
map("n", "<leader>ab", "<cmd>AnyJumpBack<CR>")
map("n", "<leader>al", "<cmd>AnyJumpLastResults<CR>")

-- goto-preview
map("n", "gpd", '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map("n", "gpi", '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
map("n", "gP", '<cmd>lua require("goto-preview").close_all_win()<CR>')
map("n", "gpr", '<cmd>lua require("goto-preview").goto_preview_references()<CR>')

-- spectre
map("n", "<leader>S", '<cmd>lua require("spectre").open()<CR>')
map("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
map("v", "<leader>s", '<cmd>lua require("spectre").open_visual()<CR>')
map("n", "<leader>sp", 'viw:lua require("spectre").open_file_search()<cr>')

-- move.nvim
map("n", "<A-j>", "<cmd>MoveLine(1)<CR>")
map("n", "<A-k>", "<cmd>MoveLine(-1)<CR>")
map("v", "<A-j>", "<cmd>MoveBlock(1)<CR>")
map("v", "<A-K>", "<cmd>MoveBlock(-1)<CR>")
map("n", "<A-l>", "<cmd>MoveHChar(1)<CR>")
map("n", "<A-h>", "<cmd>MoveHChar(-1)<CR>")
map("v", "<A-l>", "<cmd>MoveHBlock(1)<CR>")
map("v", "<A-h>", "<cmd>MoveHBlock(-1)<CR>")

keymap({ "n", "x" }, "<leader>sr", function()
  require("ssr").open()
end)
-- ufo
map("n", "zR", '<cmd>lua require("ufo").openAllFolds()<CR>')
map("n", "zM", '<cmd>lua require("ufo").closeAllFolds()<CR>')

-- LSP
map("n", "gD", "<cmd>Lspsaga peek_definition<CR>")
map("n", "ga", "<cmd>Lspsaga code_action<CR>")
map("x", "gA", "<cmd>Lspsaga range_code_action<CR>")
map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
map("n", "gr", "<cmd>Lspsaga rename<CR>")
map("n", "gi", "<cmd>Lspsaga peek_type_definition<CR>")
map("n", "gC", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
map("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
map("n", "<leader>ts", "<cmd>Lspsaga outline<CR>")
map("n", "<A-i>", "<cmd>Lspsaga term_toggle<CR>")
map("t", "<A-i>", "<C-\\><C-n><cmd>Lspsaga term_toggle<CR>")

map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
map("n", "<leader>q", "<cmd>TroubleToggle<CR>")
map("n", "<leader>F", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "gm", "<cmd>CodeActionMenu<CR>")
map("n", "gj", "<cmd>TypescriptGoToSourceDefinition<CR>")

keymap({ "n", "x" }, "<leader>sr", function()
  require("ssr").open()
end)
-- LazyGit
map("n", "<leaader><leader>g", "<cmd>LazyGit<CR>")

keymap({ "n" }, "gK", require("ts-node-action").node_action, { desc = "Trigger Node Action" })

-- telekasten
map("n", "<leader>zf", '<cmd>lua require("telekasten").find_notes()<CR>')
map("n", "<leader>zd", '<cmd>lua require("telekasten").find_daily_notes()<CR>')
map("n", "<leader>zg", '<cmd>lua require("telekasten").search_notes()<CR>')
map("n", "<leader>zz", '<cmd>lua require("telekasten").follow_link()<CR>')
map("n", "<leader>zT", '<cmd>lua require("telekasten").goto_today()<CR>')
map("n", "<leader>zw", '<cmd>lua require("telekasten").find_weekly_notes()<CR>')
map("n", "<leader>zn", '<cmd>lua require("telekasten").new_note()<CR>')
map("n", "<leader>zc", '<cmd>lua require("telekasten").show_calendar()<CR>')
map("n", "<leader>zC", "<cmd>CalendarT<CR>")
map("n", "<leader>zt", '<cmd>lua require("telekasten").toggle_todo()<CR>')
map("n", "<leader>za", '<cmd>lua require("telekasten").show_tags()<CR>')

-- Codi
map("n", "<leader>ce", "<Cmd>CodiExpand<CR>")

-- vim-project
map("n", "<leader>pl", "<Cmd>ProjectList<CR>")

-- flash.nvim
keymap({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
keymap({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
keymap({ "o" }, "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
keymap({ "x", "o" }, "s", function()
  require("flash").treesitter_search()
end, { desc = "Flash Treesitter Search" })
keymap({ "c" }, "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

cmd([[autocmd BufWritePre * %s/\s\+$//e]]) --remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

autocmd({ "TextYankPost" }, {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
  end,
  desc = "Highlight yanked text",
  group = autogroup("highlight_yank", { clear = true }),
})

autocmd({ "FileType" }, {
  pattern = "*.toml",
  callback = function()
    require("cmp").setup.buffer({ sources = { { name = "crates" } } })
  end,
  desc = "Add cmp source for toml",
})

autocmd({ "FileType" }, {
  pattern = "*.json",
  callback = function()
    require("cmp").setup.buffer({ sources = { { name = "npm", keyword_length = 3 } } })
  end,
  desc = "Add cmp source for json",
})

local numbers = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
for _, num in pairs(numbers) do
  map("n", "<leader>" .. num, "<cmd>BufferGoto " .. num .. "<CR>")
end
map("n", "<leader>0", "<cmd>BufferGoto 10<CR>")

g.markdown_fenced_language = {
  "ts=typescript",
}
g.markdown_fenced_languages = { "javascript", "typescript", "bash", "lua", "go", "rust", "c", "cpp" }

--theme
cmd("colorscheme base16-ayu-dark")

-- vim-better-whitespace
g.better_whitespace_filetypes_blacklist = { "diff", "git", "qf", "help", "fugitive", "minimap" }

local startify = require("alpha.themes.startify")
local header = {
  "┍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┑",
  "│ ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷ │",
  "│ ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇ │",
  "│ ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽ │",
  "│ ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕ │",
  "│ ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕ │",
  "│ ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕ │",
  "│ ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄ │",
  "│ ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕ │",
  "│ ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿ │",
  "│ ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ │",
  "│ ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟ │",
  "│ ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠ │",
  "│ ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙ │",
  "│ ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣ │",
  "┕━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┙",
  "+--------------------------------+",
  "|      Love You, 小璇同学❤❤❤     |",
  "+----------------+---------------+",
}

-- 布局
startify.section.header.val = header
-- 高亮
-- startify.section.header.opts.hl = 'AlphaHeader'

require("alpha").setup(startify.opts)

cmd([[ let @r="\y:%s/\<C-r>\"//g\<Left>\<Left>" ]])
cmd([[ let @h=":ProjectRoot \<CR> :w\<CR> :vsp | terminal  go run *.go \<CR>i" ]])
cmd([[ let @1=":call CppComp() \<CR>G:66\<CR>" ]])
cmd([[ let @c=":cd %:h \<CR>" ]])
-- 按 @g 运行代码
-- All previous macros have been changed to autocmd, @g macro will run current file
cmd([[
	augroup run_file
		autocmd BufEnter *.java let @g=":w\<CR>:vsp | terminal java %\<CR>i"
		autocmd BufEnter *.py let @g=":w\<CR>:vsp |terminal python %\<CR>i"
		autocmd BufEnter *.asm let @g=":w\<CR> :!nasm -f elf64 -o out.o % && ld out.o -o a.out \<CR> | :vsp |terminal ./a.out\<CR>i"
		autocmd BufEnter *.cpp let @g=":w\<CR> :!g++ %\<CR> | :vsp |terminal ./a.out\<CR>i"
		autocmd BufEnter *.c let @g=":w\<CR> :!gcc %\<CR> | :vsp |terminal ./a.out\<CR>i"
		autocmd BufEnter *.go let @g=":w\<CR> :vsp | terminal go run % \<CR>i"
		autocmd BufEnter *.js let @g=":w\<CR> :vsp | terminal node % \<CR>i"
		autocmd BufEnter *.html let @g=":w\<CR> :silent !chromium % \<CR>"
	augroup end
]])

cmd([[
  " highlight IndentBlanklineIndent1 guifg=#E06C75
  " highlight IndentBlanklineIndent2 guifg=#E5C07B
  " highlight IndentBlanklineIndent3 guifg=#98C379
  " highlight IndentBlanklineIndent4 guifg=#56B6C2
  " highlight IndentBlanklineIndent5 guifg=#61AFEF
  " highlight IndentBlanklineIndent6 guifg=#C678DD
  highlight link LspSagaFinderSelection Search

  highlight Normal ctermbg=NONE guibg=NONE
  hi default link HlSearchNear IncSearch
  hi default link HlSearchLens WildMenu
  hi default link HlSearchLensNear IncSearch
  hi default link HlSearchFloat IncSearch
  highlight MarkSignHL guifg=#E06C75
  highlight MarkSignNumHL guifg=#E5C07B
  highlight MarkVirtTextHL guifg=#98C379
  hi tkLink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
  hi tkBrackets ctermfg=gray guifg=gray
  hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

  hi link CalNavi CalRuler
  hi tkTagSep ctermfg=gray guifg=gray
  hi tkTag ctermfg=175 guifg=#d3869B
]])
