local ok, _ = pcall(require, 'impatient')
if ok then
  -- require('impatient') -- 必须是第一加载
  require('impatient').enable_profile()
end
local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap
-- local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
-- local usercmd = vim.api.nvim_create_user_command

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

g.mapleader = " " --leader
g.maplocalleader = ","

nvim_exec([[set guifont=Operator\ Mono\ Lig:h18,VictorMono\ NF:h16]], false)
g.neovide_scale_factor = 1.0
g.neovide_input_macos_alt_is_meta = true

--set shortmess
vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.sessionoptions = "buffers,help,tabpages"
vim.opt.fillchars:append('fold:•')

nvim_exec([[
filetype plugin on
filetype indent on
]], false)

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/glepnir/nvim-lua-guide-zh
-- https://github.com/neovim/neovim/wiki/Related-projects#Plugins
-- using :source % or :luafile %
-- log: nvim -V9myNvim.log
cmd [[packadd packer.nvim]]
local packer = require('packer')
packer.startup({ function()
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use {'antoinemadec/FixCursorHold.nvim', opt = true, event = 'BufRead'}
  use 'LunarVim/bigfile.nvim'
  -- 状态栏
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use {'windwp/windline.nvim', config = function() require('modules.windline') end}
  use {'kyazdani42/nvim-tree.lua', opt = true, cmd = 'NvimTreeToggle', config = function() require 'modules.nvim-tree' end}
  use 'goolord/alpha-nvim'
  -- git相关
  use {'lewis6991/gitsigns.nvim', opt = true, event = 'BufRead', config = function() require 'modules.gitsigns' end}
  use 'tpope/vim-fugitive'
  use {'kdheepak/lazygit.nvim', opt = true, cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitFilter', 'LazyGitFilterCurrentFile' }}
  use {'akinsho/git-conflict.nvim', opt = true, cmd = { 'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth', 'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict' }, config = function() require('git-conflict').setup() end}
  use {'rbong/vim-flog', opt = true, cmd = { 'Flog' }}
  use {'sindrets/diffview.nvim', opt = true, cmd = { 'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles' }, config = function() require('diffview').setup() end}
  -- 语法高亮
  use {'kevinhwang91/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/nvim-treesitter-textobjects', opt = true, event = 'InsertEnter'}
  use {'nvim-treesitter/nvim-treesitter-context', opt = true, event = 'BufRead', config = function() require 'treesitter-context'.setup() end}
  -- use {'haringsrob/nvim_context_vt', event = 'BufRead', config = function() require('nvim_context_vt'):setup() end}
  use {'folke/twilight.nvim', opt = true, cmd = { 'Twilight' }, config = function() require('twilight'):setup() end}
  use {'NvChad/nvim-colorizer.lua', opt = true, event = 'BufRead', config = function() require 'modules.colorizer' end } -- 色值高亮
  -- theme 主题 -- https://vimcolorschemes.com/
  use 'RRethy/nvim-base16'
  use {'Mofiqul/vscode.nvim', 'sternelee/synthwave84.nvim', 'katawful/kat.nvim'}
  -- 显示导航线
  use {'lukas-reineke/indent-blankline.nvim', event = 'BufRead', config = function() require 'modules.indent_blankline' end}
  use {'mg979/vim-visual-multi', opt = true, event = 'InsertEnter'}
  use {'terryma/vim-expand-region', opt = true, event = 'BufRead'}
  use {'fedepujol/move.nvim', opt = true, event = 'BufRead'}
  use {'kevinhwang91/nvim-hlslens', opt = true, event = 'BufRead', config = function() require('modules.hlslens') end}
  use {'phaazon/hop.nvim', opt = true, cmd = { 'HopWord', 'HopLine', 'HopPattern' }, config = function() require('hop'):setup() end}
  -- use {'ggandor/lightspeed.nvim', opt = true, event = 'BufRead'}
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-packer.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'ahmedkhalf/project.nvim', config = function() require 'project_nvim'.setup {} end}
  use {'toppair/reach.nvim', opt = true, event = 'BufRead', config = function() require('reach').setup{ notifications = true } end}
  -- 语法建议
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use {'aduros/ai.vim', opt = true, cmd = 'AI'}
  -- use({
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   opt = true,
  --   event = 'BufRead',
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- })
  use {'jose-elias-alvarez/typescript.nvim', opt = true, ft = { 'typescript', 'typescriptreact', 'vue' }, config = function() require 'modules.typescript' end}
  use 'b0o/schemastore.nvim' -- json server
  use {'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets' } }
  use {'hrsh7th/nvim-cmp', requires = {
    { 'petertriho/cmp-git' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
    { 'hrsh7th/cmp-calc' },
    { 'hrsh7th/cmp-emoji' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-cmdline' },
    -- {'octaltree/cmp-look'}, -- 太多了
    -- {'dmitmel/cmp-digraphs'},
    -- {'tzachar/cmp-tabnine', run='./install.sh'}, -- 内存占用太大
    -- {'ray-x/cmp-treesitter'},
    -- {'f3fora/cmp-spell'}, -- look更好
  }}
  use {'ThePrimeagen/refactoring.nvim', opt = true, event = 'BufRead', config = function()
    require('refactoring').setup()
    require 'telescope'.load_extension('refactoring')
  end}
  -- 语法提示
  use {'kevinhwang91/nvim-bqf', ft = 'qf', event = 'BufRead', config = function() require('bqf'):setup() end}
  use {'glepnir/lspsaga.nvim', opt = true, event = 'BufRead', branch = 'main', config = function() require 'modules.saga' end}
  use {'weilbith/nvim-code-action-menu', opt = true, cmd = 'CodeActionMenu'}
  use 'onsails/lspkind-nvim'
  -- use { 'jose-elias-alvarez/null-ls.nvim', opt = true, event = 'BufRead',
  --   config = function() require 'modules.null-ls' end }
  -- use { "rcarriga/nvim-dap-ui", opt = true, event = 'BufRead', requires = { "mfussenegger/nvim-dap" },
  -- config = function() require 'modules.dap' end }
  -- use {'j-hui/fidget.nvim', event = 'BufRead', config = function() require('fidget'):setup() end} -- 用noice代替
  -- rust
  use { 'simrat39/rust-tools.nvim',
    ft = 'rust',
    event = 'BufRead',
    config = function()
      require('rust-tools').setup({
        tools = {
          autoSetHints = true,
          runnables = { use_telescope = true },
          inlay_hints = { show_parameter_hints = true },
          hover_actions = { auto_focus = true }
        }
      })
    end }
  use {'Saecki/crates.nvim', opt = true, event = { "BufRead Cargo.toml" }, config = function() require('crates').setup() end}
  use {'David-Kunz/cmp-npm', opt = true, event = 'BufRead package.json', config = function() require('cmp-npm').setup({}) end}
  use {'vuki656/package-info.nvim', opt = true, event = 'BufRead package.json', config = function() require('package-info').setup { package_manager = 'pnpm' } end}
  use {'NTBBloodbath/rest.nvim', opt = true, ft = 'http', config = function() require 'rest-nvim'.setup() end}
  use {'pechorin/any-jump.vim', opt = true, cmd = { 'AnyJump', 'AnyJumpVisual', 'AnyJumpBack' }}
  use {'editorconfig/editorconfig-vim', opt = true, event = 'BufRead'}
  use {'rmagatti/goto-preview', opt = true, ft = { 'typescript', 'javascript', 'typescriptreact', 'rust', 'vue' }, evnet = 'BufRead', config = function() require('goto-preview').setup {} end}
  -- use {'napmn/react-extract.nvim', config = function() require('react-extract').setup() end} -- 重构react组件
  use {'yardnsm/vim-import-cost', run = 'npm install --production'}
  -- 方便操作
  use {"max397574/better-escape.nvim", opt = true, event = 'InsertEnter', config = function() require("better_escape").setup() end}
  -- use {"ellisonleao/glow.nvim", opt = true, ft = 'markdown', cmd = 'Glow', config = function() require('glow') end}
  use {'iamcco/markdown-preview.nvim', opt = true, ft = 'markdown', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  use {'nacro90/numb.nvim', opt = true, event = 'BufRead', config = function() require('numb').setup() end}
  use {'tpope/vim-eunuch', opt = true, cmd = { 'Delete', 'Mkdir', 'Rename' }}
  use {'voldikss/vim-translator', opt = true, cmd = { 'Translate' }} -- npm install fanyi -g 安装翻译
  -- use {'tpope/vim-commentary', opt = true, event = 'BufRead' }
  use {'numToStr/Comment.nvim', config = function() require('Comment').setup() end}
  use {'ZhiyuanLck/smart-pairs', opt = true, event = 'InsertEnter', config = function() require('pairs'):setup() end}
  use {'machakann/vim-sandwich', opt = true, event = 'InsertEnter'}
  -- use({
  --   "kylechui/nvim-surround",
  --   tag = "main",
  --   opt = true, event = 'InsertEnter',
  --   config = function()
  --       require("nvim-surround").setup{}
  --   end})
  use { 'chentoast/marks.nvim', opt = true, event = 'BufRead', config = function() require 'modules.marks' end }
  use 'folke/which-key.nvim' -- 提示leader按键
  use { 'p00f/nvim-ts-rainbow', opt = true, event = 'BufRead' } -- 彩虹匹配
  use { 'windwp/nvim-ts-autotag', opt = true, event = 'InsertEnter' }
  use { 'folke/todo-comments.nvim', opt = true, event = 'InsertEnter', config = function() require 'modules.todo' end }
  use { 'danymat/neogen', config = function() require 'neogen'.setup { enabled = true } end } -- 方便写注释
  use { 'ntpeters/vim-better-whitespace', opt = true, event = 'BufRead' }
  use { 'ThePrimeagen/vim-be-good', opt = true, cmd = 'VimBeGood' }
  use { 'mhartington/formatter.nvim', opt = true, cmd = 'Format', config = function() require 'modules.formatter' end }
  use 'rcarriga/nvim-notify'
  use { 'metakirby5/codi.vim', opt = true, cmd = { 'Codi' } }
  -- use { 'michaelb/sniprun', run = 'bash ./install.sh'}
  use { 'nvim-pack/nvim-spectre', opt = true, event = 'InsertEnter', config = function() require('spectre').setup() end }
  use { 'tpope/vim-repeat', opt = true, event = 'InsertEnter' }
  use { 'PatschD/zippy.nvim', opt = true, event = 'InsertEnter' }
  -- use {'kevinhwang91/nvim-ufo', opt = true, event = 'InsertEnter', requires = 'kevinhwang91/promise-async', config = function() require'modules.ufo' end}
  use { 'wakatime/vim-wakatime', opt = true, event = 'BufRead' }
  use { 'gennaro-tedesco/nvim-jqx', opt = true, cmd = { 'JqxList', 'JqxQuery' } }
  use { 'numToStr/FTerm.nvim', opt = true, event = 'BufRead' }
  use { 'is0n/fm-nvim', opt = true, event = 'BufRead' }
  use {
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("noice").setup {
        messages = { enabled = false },
        -- lsp_progress = { enabled = false },
        views = {
          messages = {
            view = "split",
            enter = true,
          },
          cmdline_popup = {
            position = {
              row = 8,
            },
          },
          popupmenu = {
            position = {
              row = 8,
            },
          }
        }
      }
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
  use {"petertriho/nvim-scrollbar", config = function()require("scrollbar").setup() end}
end,
  config = {
    profile = {
      enabled = true,
      threshold = 1
    }
  } })

--settings
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
opt('b', 'expandtab', true) -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent) -- Size of an indent
opt('b', 'smartindent', true) -- Insert indents automatically
opt('b', 'tabstop', indent) -- Number of spaces tabs count for
opt('o', 'completeopt', 'menu,menuone,noselect') -- Completion options
opt('o', 'hidden', true) -- Enable modified buffers in background
opt('o', 'scrolloff', 3) -- Lines of context
opt('o', 'shiftround', true) -- Round indent
opt('o', 'sidescrolloff', 8) -- Columns of context
opt('o', 'smartcase', true) -- Don't ignore case with capitals
opt('o', 'splitbelow', true) -- Put new windows below current
opt('o', 'splitright', true) -- Put new windows right of current
opt('o', 'termguicolors', true) -- True color support
opt('o', 'clipboard', 'unnamedplus') -- 与系统剪切板相通
opt('o', 'pumblend', 25)
opt('o', 'softtabstop', 2)
opt('o', 'swapfile', false)
opt('o', 'showmode', false)
opt('o', 'background', 'dark')
opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('w', 'number', true) -- Print line number
opt('o', 'lazyredraw', false)
opt('o', 'signcolumn', 'yes')
opt('o', 'mouse', 'a')
opt('o', 'cmdheight', 0)
opt('o', 'wrap', false)
opt('o', 'relativenumber', true)
opt('o', 'hlsearch', true)
opt('o', 'inccommand', 'split')
opt('o', 'smarttab', true)
opt('o', 'incsearch', true)
opt('o', 'foldmethod', 'indent')
-- opt('o', 'foldcolumn', '1')
opt('o', 'foldenable', true)
opt('o', 'foldlevel', 99)
opt('o', 'foldlevelstart', 99)
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
opt('o', 'timeoutlen', 500)
opt('o', 'history', 500)
opt('o', 'ttimeoutlen', 10)
opt('o', 'updatetime', 300)
opt('o', 'scrolljump', 6)
opt('o', 'undofile', true)
opt('o', 'showtabline', 2)
-- opt('o', 'spell', true)
-- opt('o', 'spelllang', 'en_us')

--mappings
local function map(mode, lhs, rhs)
  local options = { noremap = true }
  remap(mode, lhs, rhs, options)
end

map('v', 'x', 'd')
map('v', 'd', '"_d')
map('n', 'P', '"0p')
map('v', 'P', '"0p')
-- map('i', 'jk', '<esc>')                                               --jk to exit
-- map('c', 'jk', '<C-C>')
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
map('n', '<leader><leader>i', '<cmd>PackerInstall<CR>')
map('n', '<leader><leader>u', '<cmd>PackerUpdate<CR>')
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

-- ufo
-- map('n', 'zR', '<cmd>lua require("ufo").openAllFolds()<CR>')
-- map('n', 'zM', '<cmd>lua require("ufo").closeAllFolds()<CR>')

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

map('n', 'gD', '<cmd>Lspsaga preview_definition<CR>')
-- map('n', '<leader>l', '<cmd>Lspsaga lsp_finder<CR>')
map('n', 'ga', '<cmd>Lspsaga code_action<CR>')
map('x', 'gA', '<cmd>Lspsaga range_code_action<CR>')
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
map('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>')
map('n', 'gr', '<cmd>Lspsaga rename<CR>')
map('n', 'gi', '<cmd>Lspsaga implement<CR>')
map('n', 'gC', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
map('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')
map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
map('n', '<leader>ts', '<cmd>LSoutlineToggle<CR>')

-- map('t', '<A-i>', '<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>')
-- map('n', '<A-i>', '<cmd>Lspsaga open_floaterm custom_cli_command<CR>')

map('n', '<A-i>', '<cmd>lua require("FTerm").toggle()<CR>')
map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- sniprun
-- map('n', "<A-n>", ":SnipRun<CR>")
-- map('v', "<A-n>", ":'<,'>SnipRun<CR>")

map('n', 'gz', '<mcd>lua require("zippy").insert_print()<CR>')

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
  background_colour = '#000000'
}
vim.notify = notify

vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({
    'ERROR',
    'WARN',
    'INFO',
    'DEBUG',
  })[result.type]
  notify({ result.message }, lvl, {
    title = 'LSP | ' .. client.name,
    timeout = 2000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end

require 'modules.telescope'
require 'modules.treesitter'

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
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif require("neogen").jumpable() then
        require("neogen").jump_next()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif require("neogen").jumpable() then
        require("neogen").jump_prev()
      else
        fallback()
      end
    end, { "i", "s" }),
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


cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'cmdline' }
  })
})

-- LSP config
require('lsp/config')

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
}

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.name == 'tailwindcss' then
    if client.server_capabilities.colorProvider then
      require "lsp/documentcolors".buf_attach(bufnr)
    end
  end

  -- if client.name ~= 'jsonls' then
  --   local msg = string.format("Language server %s started!", client.name)
  --   notify(msg, 'info', {title = 'LSP Notify', timeout = '100'})
  -- end

end

local lspconfig = require("lspconfig")
local lsputil = require 'lspconfig.util'

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "html", "cssls", "jsonls", "tsserver", "emmet_ls" },
  automatic_installation = true
})

local servers = {
  "sumneko_lua",
  "html",
  "cssls",
  "jsonls",
  "emmet_ls",
  "vuels",
  "volar",
  "tsserver",
  "denols",
  "rust_analyzer",
  "eslint",
  "tailwindcss",
  "bashls",
  "marksman"
}

local function setup_servers()
  for _, lsp in ipairs(servers) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = handlers,
    }
    if lsp == "jsonls" then
      opts.settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      }
    end
    if lsp == "tsserver" then
      opts.root_dir = lsputil.root_pattern('package.json')
      opts.capabilities = require('lsp/tsserver').capabilities
      opts.settings = require('lsp/tsserver').settings
    end
    if lsp == "denols" then
      opts.root_dir = lsputil.root_pattern('deno.json', 'deno.jsonc')
    end
    if lsp == "vuels" then
      opts.root_dir = lsputil.root_pattern('.veturrc')
    end
    if lsp == "volar" then
      opts.root_dir = lsputil.root_pattern('.volarrc')
    end
    if lsp == "sumneko_lua" then
      opts.settings = require('lsp/sumneko_lua').settings
    end
    if lsp == "eslint" then
      opts.root_dir = lsputil.root_pattern('.eslintrc', '.eslintrc.js', '.eslintignore')
      opts.settings = require('lsp/eslint').settings
      opts.handlers = {
        ['window/showMessageRequest'] = function(_, result, params) return result end
      }
    end
    if lsp == "tailwindcss" then
      opts.root_dir = lsputil.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js',
    'postcss.config.ts', 'package.json', 'node_modules')
      opts.filetypes = require('lsp/tailwindcss').filetypes
      opts.capabilities = require('lsp/tailwindcss').capabilities
      opts.init_options = require('lsp/tailwindcss').init_options
      opts.settings = require('lsp/tailwindcss').settings
    end
    lspconfig[lsp].setup(opts)
  end
end

setup_servers()

-- eslint autoFixOnSave
local function can_autofix(client)
  return client.config.settings.autoFixOnSave or false
  -- return eslint_autofix or false
end

local function fix_on_save()
  local clients = vim.lsp.get_active_clients()
  local can_autofix_clients = vim.tbl_filter(can_autofix, clients)
  if #can_autofix_clients > 0 then
    execute('EslintFixAll')
  end
end

autocmd({ "BufWritePre" }, {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.vue" },
  -- command = 'EslintFixAll',
  callback = fix_on_save,
  desc = "Eslint Fix All"
})

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
]]
