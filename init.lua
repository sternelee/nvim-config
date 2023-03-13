local cmd = vim.cmd
local g = vim.g
-- local fn = vim.fn
-- local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
-- local usercmd = vim.api.nvim_create_user_command

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

g.mapleader = " " --leader
g.maplocalleader = ","

nvim_exec([[set guifont=Dank\ Mono:h20,VictorMono\ NF:h18]], false)

g.neovide_scale_factor = 1.0
g.neovide_input_macos_alt_is_meta = 1
g.neovide_input_use_logo = 1
g.neovide_remember_window_size = 1
g.neovide_confirm_quit = 1
g.neovide_hide_mouse_when_typing = 0

nvim_exec([[
filetype plugin on
filetype indent on
]], false)

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/glepnir/nvim-lua-guide-zh
-- https://github.com/neovim/neovim/wiki/Related-projects#Plugins
-- using :source % or :luafile %
-- log: nvim -V9myNvim.log
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
require('lazy').setup({
  {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', 'rcarriga/nvim-notify'},
  {'antoinemadec/FixCursorHold.nvim', lazy = true, event = 'VeryLazy'},
  {'LunarVim/bigfile.nvim', config = function() require'bigfile'.config{filesize = 2,features = {'treesitter', 'lsp', 'indent_blankline'}} end},
  -- 状态栏
  {'romgrk/barbar.nvim', lazy = true, event = 'VeryLazy'},
  {'nvim-tree/nvim-web-devicons', lazy = true, event = 'VimEnter', config = function () require'nvim-web-devicons'.setup{ color_icons = true, default = true} end},
  {'windwp/windline.nvim', config = function() require('modules.windline') end},
  {'kyazdani42/nvim-tree.lua', lazy = true, cmd = 'NvimTreeToggle', config = function() require'modules.nvim-tree' end},
  {'goolord/alpha-nvim', lazy = true, event = 'VimEnter'},
  -- git相关
  {'tpope/vim-fugitive', lazy = true, event = 'VimEnter'},
  {'kdheepak/lazygit.nvim', lazy = true, cmd = {'LazyGit', 'LazyGitConfig', 'LazyGitFilter', 'LazyGitFilterCurrentFile'}},
  {'akinsho/git-conflict.nvim', lazy = true, cmd = {'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth', 'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict'}, config = function() require('git-conflict').setup() end},
  {'rbong/vim-flog', lazy = true, cmd = {'Flog'}},
  {'sindrets/diffview.nvim', lazy = true, cmd = {'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles'}, config = function () require('diffview').setup() end},
  -- 语法高亮
  {'kevinhwang91/nvim-treesitter', lazy = false, build = ':TSUpdate', config = function () require 'modules.treesitter' end },
  {'nvim-treesitter/nvim-treesitter-context', lazy = true, event = 'VeryLazy', config = function() require'treesitter-context'.setup() end},
  -- {"ziontee113/syntax-tree-surfer", lazy = true, event = 'BufWritePre', config = function() require'modules.syntax-tree-surfer' end},
  {'folke/twilight.nvim', lazy = true, cmd = {'Twilight'}, config = function() require('twilight'):setup() end},
  {'NvChad/nvim-colorizer.lua', lazy = true, event = 'VeryLazy'}, -- 色值高亮
  -- theme 主题 -- https://vimcolorschemes.com/
  {'RRethy/nvim-base16','Mofiqul/vscode.nvim', 'sternelee/synthwave84.nvim'},
  -- 显示导航线
  {'lukas-reineke/indent-blankline.nvim', event = 'VeryLazy', config = function() require'modules.indent_blankline'end}, -- 对齐线
  {'mg979/vim-visual-multi', lazy = true, event = 'VeryLazy'},
  {'terryma/vim-expand-region', lazy = true, event = 'VeryLazy'},
  {'matze/vim-move', lazy = true, event = 'VeryLazy'},
  {'phaazon/hop.nvim', lazy = true, cmd = {'HopWord', 'HopLine', 'HopPattern'}, config = function() require('hop'):setup() end},
  {'toppair/reach.nvim', lazy = true, event = 'VeryLazy', config = function() require('reach').setup{ notifications = true } end},
  {'nvim-telescope/telescope.nvim', dependencies = {'nvim-telescope/telescope-file-browser.nvim', 'ahmedkhalf/project.nvim', {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, 'nvim-telescope/telescope-symbols.nvim'}, config = function() require('modules.telescope') end},
  {'renerocksai/telekasten.nvim', dependencies = {'renerocksai/calendar-vim', 'mzlogin/vim-markdown-toc'}, lazy = true, event = 'VeryLazy', config = function() require'modules.telekasten' end}, -- 日志管理
  -- 语法建议
  {"williamboman/mason.nvim","williamboman/mason-lspconfig.nvim","neovim/nvim-lspconfig"},
  -- "folke/neoconf.nvim",
  -- {'aduros/ai.vim', lazy = true, cmd = 'AI'},
  {'Exafunction/codeium.vim', lazy = true, event = 'VeryLazy', config = function ()
    -- 注释掉 autocmd InsertEnter...等自动codeium#DebouncedComplete 那一行
    g.codeium_disable_bindings = 1
    keymap('i', '<C-k>', function() return vim.fn['codeium#Complete']() end, { expr = true }) -- 都会自动触发，会卡
    keymap('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    keymap('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    keymap('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    keymap('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  end},
  -- {'dense-analysis/neural', lazy = true, cmd = 'NeuralText', config = function() require('neural').setup{ open_ai = { api_key = vim.env.OPENAI_API_KEY }} end, dependencies = { 'MunifTanjim/nui.nvim', 'ElPiloto/significant.nvim'}},
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   lazy = true,
  --   event = 'VeryLazy',
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- },
  {'jose-elias-alvarez/typescript.nvim', lazy = true, ft = { 'typescript', 'typescriptreact', 'vue' }, config = function() require 'modules.typescript' end},
  'b0o/schemastore.nvim', -- json server
  {'L3MON4D3/LuaSnip', dependencies = { 'rafamadriz/friendly-snippets' } },
  {'hrsh7th/nvim-cmp', dependencies = {
    'lukas-reineke/cmp-under-comparator',
    'petertriho/cmp-git',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    -- 'hrsh7th/cmp-cmdline',
    -- 'octaltree/cmp-look', -- 太多了
    -- 'dmitmel/cmp-digraphs',
    -- {'tzachar/cmp-tabnine', run='./install.sh'}, -- 内存占用太大
  }},
  -- {"roobert/tailwindcss-colorizer-cmp.nvim",
  -- config = function()
  --   require("tailwindcss-colorizer-cmp").setup({
  --     color_square_width = 2,
  --   })
  -- end},
  {'ThePrimeagen/refactoring.nvim', lazy = true, event = 'InsertEnter', config = function()
    require('refactoring').setup()
    require('telescope').load_extension('refactoring')
  end},
  -- 语法提示
  {'kevinhwang91/nvim-bqf', ft = 'qf', event = 'VeryLazy', config = function() require('bqf'):setup() end},
  {'glepnir/lspsaga.nvim', lazy = true, event = 'VeryLazy', branch = 'main', config = function() require 'modules.saga' end},
  {'VidocqH/lsp-lens.nvim', lazy = true, event = 'VeryLazy', config = function () require'lsp-lens'.setup({}) end},
  {'weilbith/nvim-code-action-menu', lazy = true, cmd = 'CodeActionMenu'},
  'onsails/lspkind-nvim',
  {'jose-elias-alvarez/null-ls.nvim', lazy = true, event = 'VeryLazy', config = function() require 'modules.null-ls' end },
  -- {'mfussenegger/nvim-lint', lazy = true, event = 'VeryLazy', config = function() require'modules.lint' end},
  -- {"rcarriga/nvim-dap-ui", lazy = true, event = 'VeryLazy', dependencies = { "mfussenegger/nvim-dap"}, config = function() require 'modules.dap' end},
  {'j-hui/fidget.nvim', event = 'VeryLazy', config = function() require('fidget'):setup() end}, -- 用noice代替
  -- rust
  {'simrat39/rust-tools.nvim',
    ft = 'rust',
    event = 'VeryLazy',
    config = function()
      require('rust-tools').setup({
        tools = {
          autoSetHints = true,
          runnables = { use_telescope = true },
          inlay_hints = { show_parameter_hints = true },
          hover_actions = { auto_focus = true }
        }
      })
    end},
  {'Saecki/crates.nvim', lazy = true, event = 'BufRead Cargo.toml', config = function() require('crates').setup() end},
  {'David-Kunz/cmp-npm', lazy = true, event = 'BufRead package.json', config = function() require('cmp-npm').setup({}) end},
  {'vuki656/package-info.nvim', lazy = true, event = 'BufRead package.json', config = function() require('package-info').setup { package_manager = 'pnpm' } end},
  {'NTBBloodbath/rest.nvim', lazy = true, ft = 'http', config = function() require 'rest-nvim'.setup() end},
  {'pechorin/any-jump.vim', lazy = true, cmd = { 'AnyJump', 'AnyJumpVisual', 'AnyJumpBack' }},
  -- {'editorconfig/editorconfig-vim', lazy = true, event = 'VeryLazy'},
  {'rmagatti/goto-preview', lazy = true, ft = { 'typescript', 'javascript', 'typescriptreact', 'rust', 'vue' }, event = 'VeryLazy', config = function() require('goto-preview').setup {} end},
  -- {'napmn/react-extract.nvim', config = function() require('react-extract').setup() end} -- 重构react组件
  -- {'laytan/tailwind-sorter.nvim', lazy = true, cmd = {'TailwindSort'}, build = 'cd formatter && npm i && npm run build', config = {}},
  -- {'metakirby5/codi.vim', lazy = true, cmd = { 'Codi' }},
  -- {'phaazon/mind.nvim',branch = 'v2.2', lazy = true, event = 'VeryLazy', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require'mind'.setup() end},
  {'iamcco/markdown-preview.nvim', lazy = true, ft = 'markdown', build = 'cd app && yarn install', cmd = 'MarkdownPreview'},
  {'skywind3000/asyncrun.vim', lazy = true, cmd = 'AsyncRun'},
  {'tpope/vim-dispatch', lazy = true, cmd = {'Make', 'Dispatch', 'Focus', 'Start'}},
  --- 方便操作
  {'nacro90/numb.nvim', lazy = true, event = 'VeryLazy', config = function() require('numb').setup() end},
  {'voldikss/vim-translator', lazy = true, cmd = {'Translate'}}, -- npm install fanyi -g 安装翻译
  {'numToStr/Comment.nvim', lazy = true, event = 'VeryLazy', config = function() require('Comment').setup() end},
  {'barrett-ruth/import-cost.nvim', lazy = true, event = 'VeryLazy', build = 'sh install.sh yarn', config = function () require('import-cost').setup({}) end},
  {'machakann/vim-sandwich', lazy = true, event = 'VeryLazy'},
  {'windwp/nvim-autopairs', lazy = true, event = 'InsertEnter', config = function () require('nvim-autopairs').setup() end},
  {'utilyre/sentiment.nvim', lazy = true, event = 'VeryLazy', name = 'sentiment', version = "*",opts = {}},
  {'chentoast/marks.nvim', lazy = true, event = 'VeryLazy', config = function () require'modules.marks' end},
  {'folke/which-key.nvim', lazy = true, event = 'VeryLazy'}, -- 提示leader按键
  {'HiPhish/nvim-ts-rainbow2', lazy = true, event = 'VeryLazy'}, -- 彩虹匹配
  {'windwp/nvim-ts-autotag', lazy = true, event = 'VeryLazy' },
  {'folke/todo-comments.nvim', lazy = true, event = 'VeryLazy', config = function () require'modules.todo' end},
  {'danymat/neogen', lazy = true, event = 'VeryLazy', config = function() require'neogen'.setup { enabled = true } end}, -- 方便写jsdoc注释
  {'ntpeters/vim-better-whitespace', lazy = true, event = 'VeryLazy'},
  {'ThePrimeagen/vim-be-good', lazy = true, cmd = 'VimBeGood'},
  {'nvim-pack/nvim-spectre', lazy = true, event = 'VeryLazy', config = function() require('spectre').setup() end}, -- 全局搜索
  {'tpope/vim-repeat', lazy = true, event = 'VeryLazy'},
  {'kevinhwang91/nvim-ufo', lazy = true, event = 'VeryLazy', dependencies = 'kevinhwang91/promise-async', config = function() require'modules.ufo' end}, -- 折叠
  {'wakatime/vim-wakatime', lazy = true, event = 'VeryLazy'},
  {'gennaro-tedesco/nvim-jqx', lazy = true, cmd = {'JqxList', 'JqxQuery'}},
  {'godlygeek/tabular', lazy = true, event = 'VeryLazy'}, -- 对齐方式
  {'ckolkey/ts-node-action', lazy = true, event = 'VeryLazy', dependencies = { 'nvim-treesitter' }, config = function() require("ts-node-action").setup({})end}, -- 字符组合切换
  {'numToStr/FTerm.nvim', lazy = true, event = 'VeryLazy'},
  {'is0n/fm-nvim', lazy = true, event = 'VeryLazy'}, -- 快速使用终端命令
  {'petertriho/nvim-scrollbar', lazy = true, event = 'VeryLazy', config = function() require'scrollbar'.setup() end},
  -- {'folke/noice.nvim', event = "VimEnter", config = function() require'modules.noice' end, dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}},
  {'gelguy/wilder.nvim', lazy = true, event = 'VeryLazy', config = function() require'modules.wilder' end},
  {'cshuaimin/ssr.nvim', lazy = true, event = 'VeryLazy', module = 'ssr', config = function()
    require("ssr").setup {
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
    }
  end}

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
})

--settings
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
opt('o', 'encoding', 'utf-8')
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'scrolloff', 3)                              -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8)                          -- Columns of context
-- opt('o', 'ignorecase', true)
-- opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'clipboard', 'unnamedplus')                      -- 与系统剪切板相通
opt('o', 'pumblend', 25 )
opt('o', 'softtabstop', 2)
opt('o', 'swapfile', false)
opt('o', 'showmode', false)
opt('o', 'background', 'dark')
opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('w', 'number', true)                              -- Print line number
opt('o', 'lazyredraw', false)
opt('o', 'signcolumn', 'yes')
opt('o', 'mouse', 'a')
opt('o', 'shortmess', 'a')
opt('o', 'cmdheight', 1)
opt('o', 'wrap', false)
opt('o', 'relativenumber', true)
opt('o', 'hlsearch', true)
opt('o', 'inccommand', 'split')
opt('o', 'smarttab', true)
opt('o', 'incsearch', true)
opt('o', 'foldmethod', 'indent')
-- opt('o', 'foldmethod', 'expr')
-- opt('o', 'foldexpr', 'nvim_treesitter#foldexpr()')
-- opt('o', 'foldcolumn', '1')
opt('o', 'foldlevel', 99)
opt('o', 'foldenable', true)
opt('o', 'foldlevelstart', 99)
opt('o', 'magic', true)
opt('o', 'splitkeep', 'screen')
opt('o', 'showmode', false)
-- opt('o', 'statuscolumn', '%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " ") : " " }')
opt('o', 'sessionoptions', 'buffers,help,tabpages')
opt('o', 'fillchars', [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]])
opt('o', 'breakindent', true)
opt('o', 'lbr', true)
opt('o', 'formatoptions', 'l')
opt('o', 'laststatus', 3)
opt('o', 'cursorline', true)
opt('o', 'cursorcolumn', true)
opt('o', 'autowrite', true)
opt('o', 'autoindent', true)
opt('o', 'syntax', 'on')
opt('o', 'filetype', 'on')
opt('o', 'timeoutlen', 300)
opt('o', 'showcmd', true)
opt('o', 'history', 100)
opt('o', 'ttimeoutlen', 10)
opt('o', 'updatetime', 300)
opt('o', 'nobackup', true)
opt('o', 'nowritebackup', true)
opt('o', 'writebackup', false)
opt('o', 'scrolljump', 6)
opt('o', 'undofile', true)
opt('o', 'showtabline', 0)
-- opt('o', 'title', true)

--mappings
local function map(mode, lhs, rhs)
  local options = { noremap = true }
  remap(mode, lhs, rhs, options)
end

map('v', 'x', 'd')
map('v', 'd', '"_d')
map('n', 'P', '"0p')
map('v', 'P', '"0p')
map('i', 'jk', '<esc>')                                               --jk to exit
map('c', 'jk', '<C-C>')
map('n', ';f', '<C-f>')
map('n', ';b', '<C-b>')
-- map('n', ';', ':')                                                     --semicolon to enter command mode
map('n', 'j', 'gj') --move by visual line not actual line
map('n', 'k', 'gk')
map('n', 'q', '<cmd>q<CR>')
map('n', 'gw', '<cmd>HopWord<CR>') --easymotion/hop
map('n', 'gl', '<cmd>HopLine<CR>')
map('n', 'g/', '<cmd>HopPattern<CR>')
map('n', '<leader>:', '<cmd>terminal<CR>')
map('n', '<leader>*', '<cmd>Telescope<CR>') --fuzzy
map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
-- map('n', '<leader>m', '<cmd>Telescope marks<CR>')
map('n', '<leader>m', '<cmd>ReachOpen marks<CR>')
map('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>\'', '<cmd>Telescope resume<CR>')
map('n', 'gs', '<cmd>Telescope grep_string<CR>')
map('n', 'fg', '<cmd>Telescope git_files<CR>')
map('n', 'ft', '<cmd>Telescope treesitter<CR>')
map('n', 'fc', '<cmd>Telescope commands<CR>')
map('n', 'fe', '<cmd>Telescope file_browser<CR>')
map('n', 'fp', '<cmd>Telescope projects<CR>')
map('n', 'gq', '<cmd>Telescope diagnostics<CR>')
map('n', 'gQ', '<cmd>lua require"telescope.builtin".symbols{ sources = {"emoji", "kaomoji", "gitmoji"} }<CR>')
map('n', '<leader>ns', '<cmd>lua require("package-info").show()<CR>')
map('n', '<leader>np', '<cmd>lua require("package-info").change_version()<CR>')
map('n', '<leader>ni', '<cmd>lua require("package-info").install()<CR>')
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>tl', '<cmd>Twilight<CR>')
map('n', '<leader>tw', '<cmd>Translate<CR>')
map('n', '<leader>th', '<cmd>TSDisable highlight<CR>')
-- diffview
map('n', '<leader>td', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>tD', '<cmd>DiffviewClose<CR>')
-- wincmd
map('n', '<c-k>', '<cmd>wincmd k<CR>') --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
-- barbar
map('n', '<s-q>', '<cmd>BufferClose<CR>')
map('n', '<Tab>', '<cmd>BufferNext<CR>')
map('n', '<s-Tab>', '<cmd>BufferPrevious<CR>')
-- map('n', 'gb', '<cmd>BufferPick<CR>')
-- map('n', 'gp', '<cmd>bprevious<CR>')
-- map('n', 'gn', '<cmd>bnext<CR>')
-- map('n', '<leader>be', '<cmd>tabedit<CR>')
-- git
map('n', '<leader>ga', '<cmd>Git add %:p<CR>')
map('n', '<leader>go', '<cmd>Git add .<CR>')
map('n', '<leader>gm', '<cmd>Git commit<CR>')
map('n', '<leader>gs', '<cmd>Git status<CR>')
map('n', '<leader>gl', '<cmd>Git pull<CR>')
map('n', '<leader>gu', '<cmd>Git push<CR>')
map('n', '<leader>gr', '<cmd>Git reset --hard<CR>')
-- map('n', '<leader>gl', '<cmd>Git log<CR>')
map('n', '<leader><leader>g', '<cmd>LazyGit<CR>')

-- refactoring
map("v", "<leader>re", '<cmd>lua require("refactoring").refactor("Extract Function")<CR>')
map("v", "<leader>rf", '<cmd>lua require("refactoring").refactor("Extract Function To File")<CR>')
map("v", "<leader>rv", '<cmd>lua require("refactoring").refactor("Extract Variable")<CR>')
map("v", "<leader>ri", '<cmd>lua require("refactoring").refactor("Inline Variable")<CR>')
map("n", "<leader>ri", '<cmd>lua require("refactoring").refactor("Inline Variable")<CR>')
map("n", "<leader>rr", '<cmd><Esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>')

map('n', '<leader>j', '<cmd>AnyJump<CR>')
map('v', '<leader>j', '<cmd>AnyJumpVisual<CR>')
map('n', '<leader>ab', '<cmd>AnyJumpBack<CR>')
map('n', '<leader>al', '<cmd>AnyJumpLastResults<CR>')

-- goto-preview
map('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
map('n', 'gP',  '<cmd>lua require("goto-preview").close_all_win()<CR>')
map('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')

-- spectre
map('n', '<leader>S',  '<cmd>lua require("spectre").open()<CR>')
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
map('v', '<leader>s',  '<cmd>lua require("spectre").open_visual()<CR>')
map('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')

-- move.nvim
map('n', '<A-j>', '<cmd>MoveLine(1)<CR>')
map('n', '<A-k>', '<cmd>MoveLine(-1)<CR>')
map('v', '<A-j>', '<cmd>MoveBlock(1)<CR>')
map('v', '<A-K>', '<cmd>MoveBlock(-1)<CR>')
map('n', '<A-l>', '<cmd>MoveHChar(1)<CR>')
map('n', '<A-h>', '<cmd>MoveHChar(-1)<CR>')
map('v', '<A-l>', '<cmd>MoveHBlock(1)<CR>')
map('v', '<A-h>', '<cmd>MoveHBlock(-1)<CR>')

keymap({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
-- ufo
map('n', 'zR', '<cmd>lua require("ufo").openAllFolds()<CR>')
map('n', 'zM', '<cmd>lua require("ufo").closeAllFolds()<CR>')

-- LSP
-- map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- map('n', 'gh', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
-- map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
-- map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')

map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
map('n', '<leader>F', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')
map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
map('n', 'gm', '<cmd>CodeActionMenu<CR>')
map('n', 'gj', '<cmd>TypescriptGoToSourceDefinition<CR>')

map('n', 'gD', '<cmd>Lspsaga peek_definition<CR>')
-- map('n', '<leader>l', '<cmd>Lspsaga lsp_finder<CR>')
map('n', 'ga', '<cmd>Lspsaga code_action<CR>')
map('x', 'gA', '<cmd>Lspsaga range_code_action<CR>')
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
map('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>')
map('n', 'gr', '<cmd>Lspsaga rename<CR>')
map('n', 'gi', '<cmd>Lspsaga peek_type_definition<CR>')
map('n', 'gC', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
map('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')
map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
map('n', '<leader>ts', '<cmd>Lspsaga outline<CR>')

keymap({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
-- LazyGit
map('n', '<leaader><leader>g', '<cmd>LazyGit<CR>')

map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

keymap({ "n" }, "gK", require("ts-node-action").node_action, { desc = "Trigger Node Action" })

-- telekasten
map('n', '<leader>zf', '<cmd>lua require("telekasten").find_notes()<CR>')
map('n', '<leader>zd', '<cmd>lua require("telekasten").find_daily_notes()<CR>')
map('n', '<leader>zg', '<cmd>lua require("telekasten").search_notes()<CR>')
map('n', '<leader>zz', '<cmd>lua require("telekasten").follow_link()<CR>')
map('n', '<leader>zT', '<cmd>lua require("telekasten").goto_today()<CR>')
map('n', '<leader>zw', '<cmd>lua require("telekasten").find_weekly_notes()<CR>')
map('n', '<leader>zn', '<cmd>lua require("telekasten").new_note()<CR>')
map('n', '<leader>zc', '<cmd>lua require("telekasten").show_calendar()<CR>')
map('n', '<leader>zC', '<cmd>CalendarT<CR>')
map('n', '<leader>zt', '<cmd>lua require("telekasten").toggle_todo()<CR>')
map('n', '<leader>za', '<cmd>lua require("telekasten").show_tags()<CR>')

cmd [[autocmd BufWritePre * %s/\s\+$//e]] --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]

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
    require('cmp').setup.buffer { sources = { { name = 'crates' } } }
  end,
  desc = "Add cmp source for toml",
})

autocmd({ "FileType" }, {
  pattern = "*.json",
  callback = function()
    require('cmp').setup.buffer { sources = { { name = 'npm', keyword_length = 3 } } }
  end,
  desc = "Add cmp source for json",
})

local numbers = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
for _, num in pairs(numbers) do
  map('n', '<leader>' .. num, '<cmd>BufferGoto ' .. num .. '<CR>')
end
map('n', '<leader>0', '<cmd>BufferGoto 10<CR>')

--barbar
nvim_exec([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.auto_hide = v:true
let bufferline.icons = 'both'
]], false)

g.markdown_fenced_language = {
  "ts=typescript"
}
g.markdown_fenced_languages = { "javascript", "typescript", "bash", "lua", "go", "rust", "c", "cpp" }

--theme
cmd 'colorscheme base16-ayu-dark'

-- editorconfig-vim
g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*', '' }

-- vim-better-whitespace
g.better_whitespace_filetypes_blacklist = { 'diff', 'git', 'qf', 'help', 'fugitive', 'minimap' }

-- require("neoconf").setup()
local notify = require("notify")
notify.setup {
  timeout = 1000,
  background_colour = '#000000',
  render = "compact",
  stages = "fade",
}

vim.notify = notify

local lspkind = require('lspkind')
require 'lspkind'.init()

local cmp = require 'cmp'

require("cmp_git").setup()
local luasnip = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), {'i','s'}),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      "i",
      "s",
      "c"
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
      "c"
    }),
  },
  sources = {
    { name = 'nvim_lsp', priority = 8 },
    { name = 'luasnip', priority = 7 },
    { name = 'buffer', option = { keyword_length = 2 } },
    { name = 'nvim_lsp_signature_help' },
    { name = 'calc' },
    { name = 'emoji' },
    -- { name = 'spell' },
    -- { name = 'cmp_tabnine' },
    { name = 'git' },
    -- { name = 'digraphs' },
    -- { name = 'treesitter' },
    -- { name = 'look', keyword_length=4, option={convert_case=true, loud=true}},
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      before = function(entry, vim_item)
        return vim_item
      end
    })
  },
  -- formatting =  {
  --   format = require("tailwindcss-colorizer-cmp").formatter
  -- },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require "cmp-under-comparator".under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  experimental = {
    ghost_text = true
  }
})

-- for autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })
--
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'cmdline' }
--   })
-- })

-- LSP config
require('lsp/config')

local startify = require('alpha.themes.startify')
local header = {
  '┍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┑',
  '│ ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷ │',
  '│ ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇ │',
  '│ ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽ │',
  '│ ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕ │',
  '│ ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕ │',
  '│ ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕ │',
  '│ ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄ │',
  '│ ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕ │',
  '│ ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿ │',
  '│ ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ │',
  '│ ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟ │',
  '│ ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠ │',
  '│ ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙ │',
  '│ ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣ │',
  '┕━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┙',
}

-- 布局
startify.section.header.val = header
-- 高亮
-- startify.section.header.opts.hl = 'AlphaHeader'

require 'alpha'.setup(startify.opts)

require 'which-key'.setup {}
cmd([[ let @r="\y:%s/\<C-r>\"//g\<Left>\<Left>" ]])
cmd([[ let @h=":ProjectRoot \<CR> :w\<CR> :vsp | terminal  go run *.go \<CR>i" ]])
cmd([[ let @1=":call CppComp() \<CR>G:66\<CR>" ]])
cmd([[ let @c=":cd %:h \<CR>" ]])
-- 按 @g 运行代码
-- All previous macros have been changed to autocmd, @g macro will run current file
cmd [[
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
]]

cmd [[
  highlight IndentBlanklineIndent1 guifg=#E06C75
  highlight IndentBlanklineIndent2 guifg=#E5C07B
  highlight IndentBlanklineIndent3 guifg=#98C379
  highlight IndentBlanklineIndent4 guifg=#56B6C2
  highlight IndentBlanklineIndent5 guifg=#61AFEF
  highlight IndentBlanklineIndent6 guifg=#C678DD
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
]]
