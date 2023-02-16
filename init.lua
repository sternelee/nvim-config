local impatientOk, _ = pcall(require, 'impatient')
if impatientOk then
  require('impatient') -- 必须是第一加载
  -- require('impatient').enable_profile()
end
local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
-- local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
-- local usercmd = vim.api.nvim_create_user_command

g.loaded_netrw = 0
g.loaded_netrwPlugin = 0
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

g.mapleader = " "                                                     --leader
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
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
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
  {'lewis6991/impatient.nvim', 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', 'rcarriga/nvim-notify'},
  {'antoinemadec/FixCursorHold.nvim', lazy = true, event = 'VeryLazy'},
  {'LunarVim/bigfile.nvim', config = function() require'bigfile'.config{filesize = 1,features = {'treesitter', 'lsp', 'indent_blankline'}} end},
  -- 状态栏
  {'romgrk/barbar.nvim', lazy = true, event = 'VeryLazy'},
  {'nvim-tree/nvim-web-devicons', lazy = true, event = 'VimEnter', config = function ()
    require'nvim-web-devicons'.setup{
      override = {
        vue = {
          icon = "﵂",
          color = "#428850",
          cterm_color = "107",
          name = "Vue"
        }
      },
      color_icons = true,
      default = true}
  end},
  {'nvim-lualine/lualine.nvim', config = function() require'modules.lualine' end},
  {'kyazdani42/nvim-tree.lua', lazy = true, cmd = 'NvimTreeToggle', config = function() require'modules.nvim-tree' end},
  {'goolord/alpha-nvim', lazy = true, event = 'VimEnter'},
  -- git相关
  {'tpope/vim-fugitive', lazy = true, event = 'VimEnter'},
  {'kdheepak/lazygit.nvim', lazy = true, cmd = {'LazyGit', 'LazyGitConfig', 'LazyGitFilter', 'LazyGitFilterCurrentFile'}},
  {'akinsho/git-conflict.nvim', lazy = true, cmd = {'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth', 'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict'}, config = function() require('git-conflict').setup() end},
  {'rbong/vim-flog', lazy = true, cmd = {'Flog'}},
  {'sindrets/diffview.nvim', lazy = true, cmd = {'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles'}, config = function () require('diffview').setup() end},
  -- 语法高亮
  {'kevinhwang91/nvim-treesitter', lazy = false, build = ':TSUpdate'},
  {'nvim-treesitter/nvim-treesitter-context', lazy = true, event = 'VeryLazy', config = function() require'treesitter-context'.setup() end},
  -- {"ziontee113/syntax-tree-surfer", lazy = true, event = 'BufWritePre', config = function() require'modules.syntax-tree-surfer' end},
  {'folke/twilight.nvim', lazy = true, cmd = {'Twilight'}, config = function() require('twilight'):setup() end},
  {'NvChad/nvim-colorizer.lua', lazy = true, event = 'VimEnter'}, -- 色值高亮
  -- {'tzachar/local-highlight.nvim', lazy = true, event = 'BufRead', config = function() require('local-highlight').setup{} end},
  -- theme 主题 -- https://vimcolorschemes.com/
  {'RRethy/nvim-base16','Mofiqul/vscode.nvim', 'sternelee/synthwave84.nvim', 'katawful/kat.nvim'},
  -- 显示导航线和操作
  {'lukas-reineke/indent-blankline.nvim', event = 'VeryLazy', config = function() require'modules.indent_blankline'end}, -- 对齐线
  {'mg979/vim-visual-multi', lazy = true, event = 'VeryLazy'},
  {'terryma/vim-expand-region', lazy = true, event = 'VeryLazy'},
  {'matze/vim-move', lazy = true, event = 'VeryLazy'},
  {'phaazon/hop.nvim', lazy = true, cmd = {'HopWord', 'HopLine', 'HopPattern'}, config = function() require('hop'):setup() end},
  {'toppair/reach.nvim', lazy = true, event = 'VeryLazy', config = function() require('reach').setup{ notifications = true } end},
  {'nvim-telescope/telescope.nvim', dependencies = {'nvim-telescope/telescope-file-browser.nvim', 'fannheyward/telescope-coc.nvim', 'ahmedkhalf/project.nvim', {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, 'nvim-telescope/telescope-symbols.nvim'}, config = function() require('modules.telescope') end},
  {'renerocksai/telekasten.nvim', dependencies = {'renerocksai/calendar-vim', 'mzlogin/vim-markdown-toc'}, lazy = true, event = 'VeryLazy', config = function() require'modules.telekasten' end}, -- 日志管理
  -- 语法提示
  {'neoclide/coc.nvim', branch = 'master', build = 'yarn install --frozen-lockfile'},
  {'weilbith/nvim-code-action-menu', dependencies = 'xiyaowong/coc-code-action-menu.nvim', config = function() require 'coc-code-action-menu' end},
  {'liuchengxu/vista.vim', lazy = true, cmd = {'Vista'}},
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
  {'vuki656/package-info.nvim', lazy = true, event = 'BufRead package.json', config = function() require('package-info').setup { package_manager = 'pnpm' } end},
  {'Saecki/crates.nvim', lazy = true, event = 'BufRead Cargo.toml', config = function() require('crates').setup() end},
  {'NTBBloodbath/rest.nvim', lazy = true, ft = 'http', config = function() require 'rest-nvim'.setup() end},
  {'pechorin/any-jump.vim', lazy = true, cmd = { 'AnyJump', 'AnyJumpVisual', 'AnyJumpBack' }},
  -- {'laytan/tailwind-sorter.nvim', lazy = true, cmd = {'TailwindSort'}, dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'}, build = 'cd formatter && npm i && npm run build', config = {}},
  -- {'metakirby5/codi.vim', lazy = true, cmd = { 'Codi' }},
  -- {'phaazon/mind.nvim',branch = 'v2.2', lazy = true, event = 'VeryLazy', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require'mind'.setup() end},
  {'iamcco/markdown-preview.nvim', lazy = true, ft = 'markdown', build = 'cd app && yarn install', cmd = 'MarkdownPreview'},
  {'skywind3000/asyncrun.vim', lazy = true, cmd = 'AsyncRun'},
  {'tpope/vim-dispatch', lazy = true, cmd = {'Make', 'Dispatch', 'Focus', 'Start'}},
  -- {'skywind3000/asynctasks.vim', lazy = true, cmd = 'AsyncTask'},
  -- 方便操作
  {'nacro90/numb.nvim', lazy = true, event = 'VeryLazy', config = function() require('numb').setup() end},
  {'voldikss/vim-translator', lazy = true, cmd = {'Translate'}}, -- npm install fanyi -g 安装翻译
  {'numToStr/Comment.nvim', lazy = true, event = 'VeryLazy', config = function() require('Comment').setup() end},
  {'barrett-ruth/import-cost.nvim', lazy = true, event = 'VeryLazy', build = 'sh install.sh yarn', config = function () require('import-cost').setup({}) end},
  {'machakann/vim-sandwich', lazy = true, event = 'VeryLazy'},
  {'chentoast/marks.nvim', lazy = true, event = 'VeryLazy', config = function () require'modules.marks' end},
  {'folke/which-key.nvim', lazy = true, event = 'VeryLazy'}, -- 提示leader按键
  {'mrjones2014/nvim-ts-rainbow', lazy = true, event = 'VeryLazy'}, -- 彩虹匹配
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
  {'gelguy/wilder.nvim', lazy = true, event = 'VeryLazy', config = function() require'modules.wilder' end},
  -- {"folke/noice.nvim", event = "VimEnter", config = function() require'modules.noice' end, dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}},
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
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
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
opt('o', 'title', true)

--mappings
local function map(mode, lhs, rhs)
  local options = {noremap = true}
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
remap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
remap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
remap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
remap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
map('n', 'j', 'gj')                                                    --move by visual line not actual line
map('n', 'k', 'gk')
map('n', 'q', '<cmd>q<CR>')

map('n', 'gw', '<cmd>HopWord<CR>')                              --easymotion/hop
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
map('n', 'gq', '<cmd>Telescope coc diagnostics<CR>')
map('n', 'gQ', '<cmd>lua require"telescope.builtin".symbols{ sources = {"emoji", "kaomoji", "gitmoji"} }<CR>')

map('n', 'gm', '<cmd>CodeActionMenu<CR>')

map('n', '<leader>ns', '<cmd>lua require("package-info").show()<CR>')
map('n', '<leader>np', '<cmd>lua require("package-info").change_version()<CR>')
map('n', '<leader>ni', '<cmd>lua require("package-info").install()<CR>')

map('n', '<leader>ct', '<cmd>lua require("crates").toggle()<CR>')
map('n', '<leader>cv', '<cmd>lua require("crates").show_versions_popup()<CR>')

map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')

map('n', '<leader>tl', '<cmd>Twilight<CR>')

map('n', '<leader>tw', '<cmd>Translate<CR>')

map('n', '<leader>tv', '<cmd>DocsViewToggle<CR>')
map('n', '<leader>to', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>tc', '<cmd>DiffviewClose<CR>')

map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
map('n', '<s-q>', '<cmd>BufferClose<CR>')
map('n', '<Tab>', '<cmd>BufferNext<CR>')
map('n', '<s-Tab>', '<cmd>BufferPrevious<CR>')
-- map('n', 'gb', '<cmd>BufferPick<CR>')
-- map('n', 'gp', '<cmd>bprevious<CR>')
-- map('n', 'gn', '<cmd>bnext<CR>')
-- map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Git add %:p<CR>')
map('n', '<leader>go', '<cmd>Git add .<CR>')
map('n', '<leader>gm', '<cmd>Git commit<CR>')
map('n', '<leader>gs', '<cmd>Git status<CR>')
map('n', '<leader>gl', '<cmd>Git pull<CR>')
map('n', '<leader>gu', '<cmd>Git push<CR>')
map('n', '<leader>gr', '<cmd>Git reset --hard<CR>')
-- map('n', '<leader>gl', '<cmd>Git log<CR>')

map('n', '<leader>j', '<cmd>AnyJump<CR>')
map('v', '<leader>j', '<cmd>AnyJumpVisual<CR>')
map('n', '<leader>ab', '<cmd>AnyJumpBack<CR>')
map('n', '<leader>al', '<cmd>AnyJumpLastResults<CR>')

-- spectre
map('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>')
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
map('v', '<leader>sv', '<cmd>lua require("spectre").open_visual()<CR>')
map('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')

-- ufo
map('n', 'zR', '<cmd>lua require("ufo").openAllFolds()<CR>')
map('n', 'zM', '<cmd>lua require("ufo").closeAllFolds()<CR>')

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

cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]

autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
    end,
    desc = "Highlight yanked text",
    group = autogroup("highlight_yank", { clear = true }),
})

-- autocmd('BufReadPost', {
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
for _, num in pairs(numbers) do
  map('n', '<leader>'..num, '<cmd>BufferGoto '..num..'<CR>')
end
map('n', '<leader>0', '<cmd>BufferGoto 10<CR>')

--barbar
nvim_exec([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:true
let bufferline.auto_hide = v:true
let bufferline.icons = 'both'
]], false)

g.vista_default_executive = 'coc'
g.markdown_fenced_language = {
  "ts=typescript"
}

--theme
cmd 'colorscheme base16-ayu-dark'

-- vim-better-whitespace
g.better_whitespace_filetypes_blacklist ={'diff', 'git', 'qf', 'help', 'fugitive', 'minimap'}

local notify = require("notify")
notify.setup{
  background_colour = '#1e1e1e'
}
vim.notify = notify

require'modules.treesitter'

local alphaOk, _ = pcall(require, 'alpha')
if alphaOk then
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

  require'alpha'.setup(startify.opts)
end

local whichKeyOk, _ = pcall(require, 'which-key')
if whichKeyOk then
  require'which-key'.setup{}
end

local colorizerOk, _ = pcall(require, 'colorizer')
if colorizerOk then
  require'colorizer'.setup{
    filetypes = { "*" },
    user_default_options = {
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      tailwindcss = true,
      sass = { enable = true, parsers = { css } }
    }
  }
end

cmd [[
  highlight IndentBlanklineIndent1 guifg=#E06C75
  highlight IndentBlanklineIndent2 guifg=#E5C07B
  highlight IndentBlanklineIndent3 guifg=#98C379
  highlight IndentBlanklineIndent4 guifg=#56B6C2
  highlight IndentBlanklineIndent5 guifg=#61AFEF
  highlight IndentBlanklineIndent6 guifg=#C678DD
  highlight MarkSignHL guifg=#E06C75
  highlight MarkSignNumHL guifg=#E5C07B
  highlight MarkVirtTextHL guifg=#98C379
  highlight Normal ctermbg=NONE guibg=NONE
  hi! link CocMenuSel CmpItemAbbrMatch
  hi! link CocInlayHint Comment
  hi! link CocSymbolLine CursorLine
  hi! link CocSymbolLineSeparator Constant
  hi! link CocSymbolLineEllipsis Function
  hi tkLink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
  hi tkBrackets ctermfg=gray guifg=gray
  hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

  hi link CalNavi CalRuler
  hi tkTagSep ctermfg=gray guifg=gray
  hi tkTag ctermfg=175 guifg=#d3869B
]]

-- coc
g.coc_global_extensions = {
  'coc-git',
  'coc-html',
  'coc-lists',
  'coc-marketplace',
  'coc-tsserver',
  'coc-json',
  'coc-css',
  'coc-emmet',
  'coc-gitignore',
  'coc-toml',
  'coc-lightbulb',
  'coc-highlight',
  'coc-pairs',
  'coc-htmlhint',
  'coc-yank',
  -- 'coc-translator',
  'coc-markdownlint',
  'coc-symbol-line',
  'coc-docthis',
  'coc-spell-checker',
  'coc-vetur',
  '@yaegassy/coc-volar',
  '@yaegassy/coc-volar-tools',
  '@yaegassy/coc-tailwindcss3',
  '@yaegassy/coc-marksman',
  'coc-todo-tree',
  'coc-html-css-support',
  'coc-stylelint'
  -- 'coc-ds-pinyin-lsp'
}

-- g.coc_start_at_startup = 0
g.coc_default_semantic_highlight_groups = 1
-- g.coc_enable_locationlist = 0
-- g.coc_selectmode_mapping = 0

-- g.trigger_size = 0.5 * 1048576

-- cmd [[
--   augroup hugefile
--     autocmd!
--     autocmd BufReadPre *
--        \ let size = getfsize(expand('<afile>')) |
--        \ if (size > g:trigger_size) || (size == -2) |
--   	   \   execute "lua vim.notify('WARNING: altering options for this huge file!', 'error', { title = 'Coc.nvim Status', timeout = 1000 })" |
--        \   exec 'CocDisable' |
--        \ else |
--        \   exec 'CocEnable' |
--        \ endif |
--        \ unlet size
--   augroup END
-- ]]

-- cmd [[
--   function! CocTimerStart(timer)
--       exec "CocStart"
--   endfunction
--   call timer_start(2000,'CocTimerStart',{'repeat':1})
-- ]]

require'modules.coc'

-- coc.nvim notify
local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = reset_coc_diag_record }
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end

cmd[[
  function! s:DiagnosticNotify() abort
    let l:info = get(b:, 'coc_diagnostic_info', {})
    if empty(l:info) | return '' | endif
    let l:msgs = []
    let l:level = 'info'
     if get(l:info, 'warning', 0)
      let l:level = 'warn'
    endif
    if get(l:info, 'error', 0)
      let l:level = 'error'
    endif

    if get(l:info, 'error', 0)
      call add(l:msgs, ' Errors: ' . l:info['error'])
    endif
    if get(l:info, 'warning', 0)
      call add(l:msgs, ' Warnings: ' . l:info['warning'])
    endif
    if get(l:info, 'information', 0)
      call add(l:msgs, ' Infos: ' . l:info['information'])
    endif
    if get(l:info, 'hint', 0)
      call add(l:msgs, ' Hints: ' . l:info['hint'])
    endif
    let l:msg = join(l:msgs, "\n")
    if empty(l:msg) | let l:msg = ' All OK' | endif
    call v:lua.coc_diag_notify(l:msg, l:level)
  endfunction

  autocmd User CocDiagnosticChange call s:DiagnosticNotify()
]]

-- 自动保存
-- require'modules.auto-save'

-- 代码运行指令
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
