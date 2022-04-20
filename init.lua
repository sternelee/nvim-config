local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap
-- local keymap = vim.keymap.set
-- local autocmd = vim.api.nvim_create_autocmd
-- local ucmd = vim.api.nvim_create_user_command

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- g.neovide_transparency=0.96
g.neovide_cursor_vfx_mode = "sonicboom"

nvim_exec([[set guifont=VictorMono\ NF:h18]], false)

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  -- execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
  execute('!git clone --depth 1 https://hub.fastgit.xyz/wbthomason/packer.nvim.git '.. install_path)
end

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/glepnir/nvim-lua-guide-zh
-- https://github.com/neovim/neovim/wiki/Related-projects#Plugins
-- using :source % or :luafile %
cmd [[packadd packer.nvim]]
local packer = require('packer')
packer.init({
  git = {
    default_url_format = "https://hub.xn--p8jhe.tw/%s"
  }
})
packer.startup({function()
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nathom/filetype.nvim'
  -- 状态栏
  use 'romgrk/barbar.nvim'
  use {'windwp/windline.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
  use 'kyazdani42/nvim-tree.lua'
  use {'goolord/alpha-nvim', lock = true}
  use 'SmiteshP/nvim-gps'
  -- git相关
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  -- use {'lambdalisue/gina.vim'}
  use {'f-person/git-blame.nvim', event = 'BufRead'}-- 显示git message
  use {'rbong/vim-flog', opt = true, cmd = {'Flog'}}
  use {'junegunn/gv.vim', opt = true, cmd = {'GV'}}
  -- 语法高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/nvim-treesitter-refactor', opt = true, event = 'InsertEnter', config = function() require('nvim-treesitter-refactor').init() end}
  use {'nvim-treesitter/nvim-treesitter-textobjects', opt = true, event = 'InsertEnter'}
  -- use 'nvim-treesitter/nvim-tree-docs'
  -- use {
  --   'romgrk/nvim-treesitter-context',
  --   opt = true,
  --   event = 'BufRead',
  --   config = function()
  --     require('treesitter-context').setup {}
  --   end} -- or nvim_context_vt
  use {'haringsrob/nvim_context_vt', event = 'BufRead', config = function() require('nvim_context_vt'):setup() end}
  use {'nvim-treesitter/playground', opt = true, cmd = {'TSPlaygroundToggle'}}
  -- use {
  --   'lewis6991/spellsitter.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     require('spellsitter').setup()
  --   end}
  use {'folke/twilight.nvim', opt = true, cmd = {'Twilight'}, config = function() require('twilight'):setup() end}
  use 'norcalli/nvim-colorizer.lua' -- 色值高亮
  -- theme 主题 -- https://vimcolorschemes.com/
  use 'bluz71/vim-nightfly-guicolors'
  -- use 'ellisonleao/gruvbox.nvim'
  use 'Mofiqul/vscode.nvim'
  -- use {'catppuccin/nvim', as = 'catppuccin'}
  use {'amazingefren/bogsterish.nvim', requires='rktjmp/lush.nvim'}
  -- 显示导航线
  use {'lukas-reineke/indent-blankline.nvim', event = 'BufRead',
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true,
        context_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
          'IndentBlanklineIndent6',
        },
        filetype_exculde = {
          'alpha',
          'packer',
          'NvimTree',
          'lsp-install',
          'help',
          'TelescopePrompt',
          'TelescopeResults',
        },
        buftype_exclude = { 'terminal', 'nofile' },
      }
    end}
  use {'mg979/vim-visual-multi', opt = true, event = 'InsertEnter'}
  use {'kevinhwang91/nvim-hlslens', opt = true, event = 'BufRead'} -- 显示高亮的按键位置
  use {'phaazon/hop.nvim', opt = true, cmd = {'HopWord', 'HopLine', 'HopPattern'}, config = function() require('hop'):setup() end}
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-packer.nvim'
  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require'project_nvim'.setup{}
    end
  }
  -- 语法建议
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'b0o/schemastore.nvim' -- json server
  use {'github/copilot.vim', opt = true, event = 'BufRead'}
  use {'hrsh7th/nvim-cmp', requires = {
    {'petertriho/cmp-git'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-vsnip'},
    {'rafamadriz/friendly-snippets'},
    {'hrsh7th/vim-vsnip'},
    {'hrsh7th/cmp-calc'},
    {'hrsh7th/cmp-emoji'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    {'hrsh7th/cmp-cmdline'},
    {'octaltree/cmp-look'}, -- 太多了
    -- {'dmitmel/cmp-digraphs'},
    -- {'tzachar/cmp-tabnine', run='./install.sh'}, -- 内存占用太大
    -- {'ray-x/cmp-treesitter'},
    -- {'f3fora/cmp-spell'}, -- look更好
  }}
  use {'ThePrimeagen/refactoring.nvim', opt = true, event = 'BufRead', config = function ()
    require('refactoring').setup()
    require'telescope'.load_extension('refactoring')
    end}
  -- 语法提示
  -- use {'kevinhwang91/nvim-bqf', ft = 'qf', event = 'BufRead', config = function() require('bqf'):setup() end}
  -- use {'folke/trouble.nvim', event = 'BufRead', config = function() require('trouble'):setup() end}
  use {'tami5/lspsaga.nvim'}
  use {
    'weilbith/nvim-code-action-menu',
    opt = true,
    cmd = 'CodeActionMenu',
  }
  use 'onsails/lspkind-nvim'
  use {'liuchengxu/vista.vim', opt = true, cmd = {'Vista'}}
  use {'kosayoda/nvim-lightbulb', opt = true, event = 'BufRead', config = 'vim.cmd[[autocmd CursorHold,CursorHoldI * :lua require"nvim-lightbulb".update_lightbulb()]]'}
  -- use 'ray-x/lsp_signature.nvim'
  use {'j-hui/fidget.nvim', event = 'BufRead', config = function() require('fidget'):setup() end}
  -- 方便操作
  use {'tpope/vim-eunuch', opt = true, cmd = {'Delete', 'Mkdir', 'Rename'}}
  use {'gennaro-tedesco/nvim-peekup', event = 'InsertEnter'} -- 查看历史的复制和删除的寄存器,快捷键 ""
  use {'voldikss/vim-translator', opt = true, cmd = {'Translate'}} -- npm install fanyi -g 安装翻译
  use {'numToStr/Comment.nvim', requires = {'JoosepAlviste/nvim-ts-context-commentstring'}}
  use {'ZhiyuanLck/smart-pairs', event = 'InsertEnter', config = function() require('pairs'):setup() end}
  use {'windwp/nvim-ts-autotag', event = 'InsertEnter'}
  use {'machakann/vim-sandwich', event = 'InsertEnter'}
  -- use {'jdhao/better-escape.vim', event = 'InsertEnter'} -- 快速按jk退出编辑态,已经原生实现
  use {'toppair/reach.nvim', event = 'BufRead',
    config = function ()
      require('reach').setup({
        notifications = true
      })
    end}
  use {'chentau/marks.nvim', event = 'BufRead',
    config = function ()
      require('marks').setup({
        default_mappings = true,
        builtin_marks = { ".", "<", ">", "^" },
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 250,
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        excluded_filetypes = {},
        bookmark_0 = {
          sign = "⚑",
          virt_text = "sterne"
        },
        mappings = {}
      })
    end}
  use 'folke/which-key.nvim' -- 提示leader按键
  use {'p00f/nvim-ts-rainbow', opt = true, event = 'BufRead'} -- 彩虹匹配
  use {'pechorin/any-jump.vim', opt = true, cmd = {'AnyJump'}}
  -- use {'hoschi/yode-nvim', event = 'BufRead', config = function () require('yode-nvim').setup({}) end}
  use 'folke/todo-comments.nvim'
  use {
    'danymat/neogen',
    requires = 'nvim-treesitter/nvim-treesitter',
    event = 'InsertEnter',
    config = function()
      require'neogen'.setup {
          enabled = true
      }
    end} -- 方便写注释
  use {'renerocksai/telekasten.nvim', requires = {
    'renerocksai/calendar-vim',
    -- 'nvim-telescope/telescope-media-files.nvim'
  }} -- 笔记
  use 'ntpeters/vim-better-whitespace'
  use 'ThePrimeagen/vim-be-good'
  use 'mhartington/formatter.nvim'
  use 'rcarriga/nvim-notify'
  use {'metakirby5/codi.vim', opt = true, cmd = {'Codi'}}
  use {'turbio/bracey.vim', opt = true, cmd = 'Bracey'}
  use {
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    event = 'BufRead package.json',
    config = function()
      require('package-info').setup()
    end}
  -- rust
  use {'simrat39/rust-tools.nvim',
    ft = 'rust',
    event = 'BufRead',
    config = function()
      require('rust-tools'):setup{
        tools = {
          autoSetHints = true,
          runnables = { use_telescope = true },
          inlay_hints = { show_parameter_hints = true },
          hover_actions = { auto_focus = true }
        }
      }
    end}
  use {'Saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function()
        require('crates').setup()
    end}
  use {'David-Kunz/cmp-npm',
    opt = true,
    event = 'BufRead package.json',
    config = function()
      require('cmp-npm').setup({})
    end}
  use {
    'NTBBloodbath/rest.nvim',
    ft = 'http',
    requires = {"nvim-lua/plenary.nvim" },
    config = function()
      require'rest-nvim'.setup() end}
  -- use { 'chipsenkbeil/distant.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     require('distant').setup {
  --       ['*'] = require('distant.settings').chip_default()
  --     }
  --   end }
  -- use 'nanotee/sqls.nvim'
  -- use {'brooth/far.vim', event = 'InsertEnter'} -- or nvim-pack/nvim-spectre 全局替换
  use {'nvim-pack/nvim-spectre',
    opt = true,
    event = 'InsertEnter',
    config = function()
      require('spectre').setup()
      require('windline').add_status(
        require('spectre.state_utils').status_line()
      )
    end
  }
  use {'tpope/vim-repeat', event = 'InsertEnter'}
  -- use {
  --   'rmagatti/auto-session',
  --   config = function()
  --     require('auto-session').setup {}
  --   end
  -- }
  use {
    'rmagatti/goto-preview',
    opt = true,
    evnet = 'BufRead',
    config = function()
      require('goto-preview').setup {}
    end
  }
  -- use {
  --   'willchao612/vim-diagon',
  --   opt = true,
  --   ft = 'markdown'
  -- }
  use {
    'kkoomen/vim-doge',
    opt = true,
    cmd = {'DogeGenerate', 'DogeCreateDocStandard'},
    run = ':call doge#install()'
  }
  -- use {
  --   'rcarriga/nvim-dap-ui',
  --   event = 'BufRead',
  --   requires = { 'mfussenegger/nvim-dap', 'Pocco81/DAPInstall.nvim', 'sidebar-nvim/sections-dap', 'theHamsta/nvim-dap-virtual-text'},
  --   config = function()
  --     require("nvim-dap-virtual-text").setup()
  --     require("dapui").setup()
  --     local dap_install = require("dap-install")
  --     dap_install.setup({
  --     	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
  --     })
  --   end}
  -- use {'sidebar-nvim/sidebar.nvim', opt = true, cmd = {'SidebarNvimToggle'},
  --   config = function()
  --     local sidebar = require("sidebar-nvim")
  --     sidebar.setup({
  --       open = false,
  --       initial_width = 30,
  --       bindings = { ["q"] = function() sidebar.close() end },
  --       sections = {
  --           "datetime",
  --           "git",
  --           "diagnostics",
  --           require("dap-sidebar-nvim.breakpoints")
  --       },
  --       dap = {
  --           breakpoints = {
  --               icon = "🔍"
  --           }
  --       }
  --     })
  --   end
  -- }
  -- use {
  -- 	'xeluxee/competitest.nvim',
  -- 	requires = 'MunifTanjim/nui.nvim',
  -- 	config = function() require'competitest'.setup() end
  -- } -- 竞技编程
  use {'iamcco/markdown-preview.nvim', opt = true, ft = 'markdown', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
end,
config = {
  profile = {
    enabled = true,
    threshold = 1
  }
}})

--settings
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'scrolloff', 3)                              -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8)                          -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
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
opt('w', 'number', true)                              -- Print line number
opt('o', 'lazyredraw', true)
opt('o', 'signcolumn', 'yes')
opt('o', 'mouse', 'a')
opt('o', 'cmdheight', 1)
opt('o', 'wrap', false)
opt('o', 'relativenumber', true)
opt('o', 'hlsearch', true)
opt('o', 'inccommand', 'split')
opt('o', 'smarttab', true)
opt('o', 'incsearch', true)
opt('o', 'foldmethod', 'indent')
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
opt('o', 'ttimeoutlen', 10)
opt('o', 'updatetime', 300)
opt('o', 'scrolljump', 6)
opt('o', 'undofile', true)
opt('o', 'showtabline', 2)
-- opt('o', 'spell', true)
-- opt('o', 'spelllang', 'en_us')

--set shortmess
vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.sessionoptions="buffers,help,tabpages"
-- vim.opt.fillchars:append('fold:•')

-- nvim_exec([[
-- filetype plugin on
-- filetype indent on
-- ]], false)

--mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  remap(mode, lhs, rhs, options)
end

g.mapleader = " "                                                     --leader
g.maplocalleader = ","
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map('n', 'd', '"_d')  --- 删除不写剪切板
map('n', 'dd', '"_dd')
map('n', 'D', '"_D')
-- map('v', 'd', '"_d')
-- map('v', 'dd', '"_dd')
-- map('n', '<c-c>', '"+y') --- mac下的复制粘贴
-- map('v', '<c-c>', '"+y')
-- map('n', '<c-v>', '"+p')
-- map('i', '<c-v>', '<c-r>+')
-- map('c', '<c-v>', '<c-r>+')
-- map('i', '<c-r>', '<c-v>')
map('i', 'jk', '<esc>')                                               --jk to exit
map('c', 'jk', '<C-C>')
map('n', ';f', '<C-f>')
map('n', ';b', '<C-b>')
-- map('n', ';', ':')                                                     --semicolon to enter command mode
map('n', 'j', 'gj')                                                    --move by visual line not actual line
map('n', 'k', 'gk')
map('n', 'q', '<cmd>q<CR>')
map('n', 'gw', '<cmd>HopWord<CR>')                              --easymotion/hop
map('n', 'gl', '<cmd>HopLine<CR>')
map('n', 'g/', '<cmd>HopPattern<CR>')
map('n', '<leader>:', '<cmd>terminal<CR>')
map('n', '<leader>*', '<cmd>Telescope<CR>')                   --fuzzy
map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
-- map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
-- map('n', '<leader>m', '<cmd>Telescope marks<CR>')
map('n', '<leader>b', '<cmd>ReachOpen buffers<CR>')
map('n', '<leader>m', '<cmd>ReachOpen marks<CR>')
map('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>\'', '<cmd>Telescope resume<CR>')
map('n', '<leader>s', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>p', '<cmd>Telescope commands<CR>')
map('n', 'ft', '<cmd>Telescope treesitter<CR>')
map('n', 'fc', '<cmd>Telescope commands<CR>')
map('n', 'fe', '<cmd>Telescope file_browser<CR>')                      --nvimtree
map('n', 'fo', '<cmd>Format<CR>')
map('n', '<leader>ns', '<cmd>lua require("package-info").show()<CR>')
map('n', '<leader>np', '<cmd>lua require("package-info").change_version()<CR>')
map('n', '<leader>ni', '<cmd>lua require("package-info").install()<CR>')
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')                      --nvimtree
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
-- map('n', '<leader>tb', '<cmd>SidebarNvimToggle<CR>')
map('n', '<leader>tl', '<cmd>Twilight<CR>')
map('n', '<leader>tw', '<cmd>Translate<CR>')
-- map('n', '<leader>th', '<cmd>lua require("hlargs").toggle()<CR>')
-- nvim-lsp-ts-utils
map('n', '<leader>to', '<cmd>TSLspOrganize<CR>')
map('n', '<leader>tn', '<cmd>TSLspRenameFile<CR>')
map('n', '<leader>ti', '<cmd>TSLspImportAll<CR>')
map('n', '<leader>sl', '<cmd>SessionLoad<CR>')
map('n', '<leader>ss', '<cmd>SessionSave<CR>')
map('n', '<leader>S', '<cmd>Vista<CR>')                   --fuzzN
map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
map('n', '<c-x>', '<cmd>BufferClose<CR>')
map('n', ';o', '<cmd>Lspsaga open_floaterm<CR>')
map('n', ';n', '<cmd>Lspsaga close_floaterm<CR>')
-- map('n', 'gb', '<cmd>BufferPick<CR>')
-- map('n', 'gp', '<cmd>bprevious<CR>')
map('n', 'gn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Git add .<CR>')
map('n', '<leader>gm', '<cmd>Git commit<CR>')
map('n', '<leader>gs', '<cmd>Git status<CR>')
map('n', '<leader>gu', '<cmd>Git pull<CR>')
map('n', '<leader>gh', '<cmd>Git push<CR>')
map('n', '<leader>gl', '<cmd>Git log<CR>')
map('n', '<leader><leader>i', '<cmd>PackerInstall<CR>')
map('n', '<leader><leader>u', '<cmd>PackerUpdate<CR>')

-- refactoring
map("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
map("n", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
map("n", "<leader>rr", [[ <Esc><Cmd><Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], {noremap = true, silent = true, expr = false})

--- zettelkasten
map('n', '<leader>zf', '<cmd>lua require("telekasten").find_notes()<CR>')
map('n', '<leader>zd', '<cmd>lua require("telekasten").find_daily_notes()<CR>')
map('n', '<leader>zg', '<cmd>lua require("telekasten").search_notes()<CR>')
map('n', '<leader>zz', '<cmd>lua require("telekasten").follow_link()<CR>')
map('n', '<leader>zp', '<cmd>lua require("telekasten").panel()<CR>')
map('n', '<leader>zc', '<cmd>CalendarVR<CR>')

map('n', '<leader>j', '<cmd>AnyJump<CR>')
map('v', '<leader>j', '<cmd>AnyJumpVisual<CR>')
map('n', '<leader>ab', '<cmd>AnyJumpBack<CR>')
map('n', '<leader>al', '<cmd>AnyJumpLastResults<CR>')

-- dapui
-- map('n', '<leader>td', '<cmd>lua require("dapui").toggle()<CR>')

-- goto-preview
map('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
map('n', 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>')
map('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')

-- copilot
g.copilot_no_tab_map = true
cmd [[
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
]]

-- spectre
map('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>')
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
map('v', '<leader>s', '<cmd>lua require("spectre").open_visual()<CR>')
map('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')

cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]

cmd[[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  augroup END
]]

cmd [[autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }]]
cmd [[autocmd FileType json lua require('cmp').setup.buffer { sources = { { name = 'npm', keyword_length = 3 } } }]]

-- https://github-wiki-see.page/m/neovim/nvim-lspconfig/wiki/UI-customization
vim.diagnostic.config({
  virtual_text = {
    prefix = '■',
    source = "always",
  },
  float = {
    source = "always",  -- Or "if_many"
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
for _, num in pairs(numbers) do
  map('n', '<leader>'..num, '<cmd>BufferGoto '..num..'<CR>')
end
map('n', '<leader>0', '<cmd>BufferGoto 10<CR>')

nvim_exec([[
let g:VM_maps = {}
let g:VM_default_mappings = 0
let g:VM_maps["Add Cursor Down"] = '<A-j>'
let g:VM_maps["Add Cursor Up"] = '<A-k>'
let g:indent_blankline_filetype_exclude = ['help', 'lspinfo', 'dashboard', 'NvimTree', 'telescope', 'packer', 'alpha']
let g:indent_blankline_buftype_exclude = ['nvim-lsp-installer', 'registers']
]], false)

--barbar
nvim_exec([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.auto_hide = v:true
let bufferline.icons = 'both'
]], false)

g.vista_default_executive = 'nvim_lsp'
g.markdown_fenced_language = {
  "ts=typescript"
}

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")

--theme
g.vscode_style = "dark"
g.vscode_italic_comment = 1
-- require'catppuccin'.setup{}
g.moonflyIgnoreDefaultColors = 1
g.nightflyCursorColor = 1
g.nightflyNormalFloat = 1

cmd 'colorscheme nightfly'

local notify = require("notify")

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
    timeout = 10000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end

local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = ' ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,

    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<M-p>'] = action_layout.toggle_preview,

        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,

        ['<esc>'] = actions.close,
        ['<C-[>'] = actions.close,

        ['<CR>'] = actions.select_default,
        ['<C-x>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-t>'] = actions.select_tab,

        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,

        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        ['<C-l>'] = actions.complete_tag,
        ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ['<M-p>'] = action_layout.toggle_preview,

        ['<esc>'] = actions.close,
        ['<C-[>'] = actions.close,

        ['<CR>'] = actions.select_default,
        ['<C-x>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-t>'] = actions.select_tab,

        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,
        ['H'] = actions.move_to_top,
        ['M'] = actions.move_to_middle,
        ['L'] = actions.move_to_bottom,

        ['gg'] = actions.move_to_top,
        ['G'] = actions.move_to_bottom,

        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,

        ['?'] = actions.which_key,
      },
    },
  },
  pickers = {
    find_files = {
      previewer = false,
    },
  },
}

require'telescope'.load_extension('file_browser')
require'telescope'.load_extension('notify')
require'telescope'.load_extension('packer')
require'telescope'.load_extension('projects')

local disableTS = function (lang, bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 10000
end

--nvim treesitter 编辑大文件卡顿时最好关闭 highlight, rainbow, autotag
require('nvim-treesitter.configs').setup {
  ensure_installed = {"vue", "html", "javascript", "typescript", "scss", "json", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash", "http"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  disable_tokenziation_after_line = 10000,
  additional_vim_regex_highlighting = false,
  highlight = {
    enable = true,
    disable = disableTS
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    disable = disableTS
  },
  autotag = {
    enable = true,
    disable = disableTS
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    disable = disableTS
  },
  tree_docs = {enable = true},
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
      set_jumps = true, -- whether to set jumps in the jumplist
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
      border = 'none',
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
  },
  incremental_selection = {
    enable = true,
    disable = { "cpp", "lua" },
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    }
  },
}

local lspkind = require('lspkind')
require'lspkind'.init()
local cmp = require'cmp'

require("cmp_git").setup()

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noselect',
    border = true,
    scrollbar = true
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end
    },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer', option={keyword_length=2} },
    { name = 'nvim_lsp_signature_help' },
    { name = 'calc' },
    { name = 'emoji' },
    -- { name = 'spell' },
    -- { name = 'cmp_tabnine' },
    { name = 'cmp_git' },
    -- { name = 'digraphs' },
    -- { name = 'treesitter' },
    { name = 'look', keyword_length=4, option={convert_case=true, loud=true}},
  },
  formatting = {
    format = lspkind.cmp_format()
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
    { name = 'cmp_git' },
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
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'single'
  }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signatureHelp, {
    border = 'single'
  }
)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', '<leader>l', '<cmd>Lspsaga lsp_finder<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('x', 'gA', '<cmd>Lspsaga range_code_action<CR>', opts)
  buf_set_keymap('n', 'gam', '<cmd>CodeActionMenu<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Lspsaga implement<CR>', opts)
  buf_set_keymap('n', 'gE', '<cmd>Lspsaga preview_definition<CR>', opts)
  buf_set_keymap('n', 'gC', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)


  -- if client.name == 'sqls' then
  --   require('sqls').on_attach(client, bufnr)
  -- end

  if client.name == 'tsserver' then
    local ts_utils = require("nvim-lsp-ts-utils")
    local init_options = require("nvim-lsp-ts-utils").init_options
    ts_utils.setup(init_options)
    ts_utils.setup_client(client)
  end

  if client.name ~= 'jsonls' then
    local msg = string.format("Language server %s started!", client.name)
    notify(msg, 'info', {title = 'LSP Notify', timeout = '300'})
    -- require'lsp_signature'.on_attach({
    --   bind = true,
    --   handler_opts = {
    --     border = "rounded"
    --   }
    -- }, bufnr)
  end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function setup_servers()
  local lsp_installer = require("nvim-lsp-installer")
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  lsp_installer.on_server_ready(function(server)
    if server.name == "jsonls" then
      opts.settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      }
    end
    server:setup(opts)
  end)
end

setup_servers()

-- vim.lsp.set_log_level("debug")

require'nvim-tree'.setup {
  auto_reload_on_write = true,
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore              = {".git", "node_modules", ".cache"},
  hide_dotfiles       = 1,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  system_open = {
    cmd  = nil,
    args = {}
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = { ".git", "node_modules", ".cache" },
  },
  view = {
    width = 20,
    side = 'right',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  diagnostic = {
    enable = true
  },
  git = {
    enable = true
  }
}

--gitsigns
require'gitsigns'.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
  watch_gitdir = {
    interval = 1000
  },
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  diff_opts = {
    internal = false
  }
}

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

require'alpha'.setup(startify.opts)

--[[ local prettier = function ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
    stdin = true
  }
end ]]

-- npm install -g @fsouza/prettierd
local prettierd = function ()
  return {
    exe = "prettierd",
    args = {vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require('formatter').setup({
  filetype = {
    javascript = {
      prettierd
    },
    javascriptreact = {
      prettierd
    },
    typescript = {
      prettierd
    },
    typescriptreact = {
      prettierd
    },
    vue = {
      prettierd
    },
    json = {
      prettierd
    },
    html = {
      prettierd
    },
    css = {
      prettierd
    },
    sass = {
      prettierd
    },
    scss = {
      prettierd
    },
    less = {
      prettierd
    }
  }
})

require'which-key'.setup{}
require'colorizer'.setup{
  '*',
  css = { rgb_fn = true; }
}

require('todo-comments').setup{
  signs = true,
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    merge_keywords = true,
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[(KEYWORDS)]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },
    colors = {
      error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
      warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
      info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
      hint = { "LspDiagnosticsDefaultHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
}

require'Comment'.setup {
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}

-- windline config
local windline = require('windline')
local helper = require('windline.helpers')
local sep = helper.separators
local b_components = require('windline.components.basic')
local state = _G.WindLine.state
local vim_components = require('windline.components.vim')
local HSL = require('wlanimation.utils')

local lsp_comps = require('windline.components.lsp')
local git_comps = require('windline.components.git')

local gps = require("nvim-gps")
gps.setup()
local hl_list = {
    Black = { 'white', 'black' },
    White = { 'black', 'white' },
    Normal = { 'NormalFg', 'NormalBg' },
    Inactive = { 'InactiveFg', 'InactiveBg' },
    Active = { 'ActiveFg', 'ActiveBg' },
}
local basic = {}

local airline_colors = {}

basic.gps = {
  function()
    if gps.is_available() then
      return ' '..gps.get_location()
    end
    return ''
  end,
  {"cyan", "NormalBg"}
}

airline_colors.a = {
    NormalSep = { 'magenta_a', 'magenta_b' },
    InsertSep = { 'green_a', 'green_b' },
    VisualSep = { 'yellow_a', 'yellow_b' },
    ReplaceSep = { 'blue_a', 'blue_b' },
    CommandSep = { 'red_a', 'red_b' },
    Normal = { 'black', 'magenta_a' },
    Insert = { 'black', 'green_a' },
    Visual = { 'black', 'yellow_a' },
    Replace = { 'black', 'blue_a' },
    Command = { 'black', 'red_a' },
}

airline_colors.b = {
    NormalSep = { 'magenta_b', 'magenta_c' },
    InsertSep = { 'green_b', 'green_c' },
    VisualSep = { 'yellow_b', 'yellow_c' },
    ReplaceSep = { 'blue_b', 'blue_c' },
    CommandSep = { 'red_b', 'red_c' },
    Normal = { 'white', 'magenta_b' },
    Insert = { 'white', 'green_b' },
    Visual = { 'white', 'yellow_b' },
    Replace = { 'white', 'blue_b' },
    Command = { 'white', 'red_b' },
}

airline_colors.c = {
    NormalSep = { 'magenta_c', 'NormalBg' },
    InsertSep = { 'green_c', 'NormalBg' },
    VisualSep = { 'yellow_c', 'NormalBg' },
    ReplaceSep = { 'blue_c', 'NormalBg' },
    CommandSep = { 'red_c', 'NormalBg' },
    Normal = { 'white', 'magenta_c' },
    Insert = { 'white', 'green_c' },
    Visual = { 'white', 'yellow_c' },
    Replace = { 'white', 'blue_c' },
    Command = { 'white', 'red_c' },
}

basic.divider = { b_components.divider, hl_list.Normal }

local width_breakpoint = 100

basic.section_a = {
    hl_colors = airline_colors.a,
    text = function(_,_,width)
        if width > width_breakpoint then
            return {
                { ' ' .. state.mode[1] .. ' ', state.mode[2] },
                { sep.right_filled, state.mode[2] .. 'Sep' },
            }
        end
        return {
            { ' ' .. state.mode[1]:sub(1, 1) .. ' ', state.mode[2] },
            { sep.right_filled, state.mode[2] .. 'Sep' },
        }
    end,
}


basic.section_b = {
    hl_colors = airline_colors.b,
    text = function(bufnr,_, width)
        if width > width_breakpoint and git_comps.is_git(bufnr) then
            return {
                { git_comps.git_branch() , state.mode[2] },
                { ' ', '' },
                { sep.right_filled, state.mode[2] .. 'Sep' },
            }
        end
        return { { sep.right_filled, state.mode[2] .. 'Sep' } }
    end,
}


basic.section_c = {
    hl_colors = airline_colors.c,
    text = function()
        return {
            { ' ', state.mode[2] },
            { b_components.cache_file_name('[No Name]', 'unique')},
            { ' '},
            { sep.right_filled, state.mode[2] .. 'Sep' },
        }
    end,
}

basic.section_x = {
    hl_colors = airline_colors.c,
    text = function(_,_,width)
        if width > width_breakpoint then
            return {
            { sep.left_filled, state.mode[2] .. 'Sep' },
            { ' ', state.mode[2] },
            { b_components.file_encoding()},
            { ' ' },
            { b_components.file_format({ icon = true }) },
            { ' ' },
            }
        end
        return {
            { sep.left_filled, state.mode[2] .. 'Sep' },
        }
    end,
}

basic.section_y = {
    hl_colors = airline_colors.b,
    text = function(_,_,width)
        if width > width_breakpoint then
            return {
                { sep.left_filled, state.mode[2] .. 'Sep' },
                { b_components.cache_file_type({ icon = true }), state.mode[2] },
                { ' ' },
            }
        end
        return { { sep.left_filled, state.mode[2] .. 'Sep' } }
    end,
}

basic.section_z = {
    hl_colors = airline_colors.a,
    text = function(_,_,width)
        if width > width_breakpoint then
            return {
                { sep.left_filled, state.mode[2] .. 'Sep' },
                { '', state.mode[2] },
                { b_components.progress_lua},
                { ' '},
                { b_components.line_col_lua},
            }
        end
        return {
            { sep.left_filled, state.mode[2] .. 'Sep' },
            { ' ', state.mode[2] },
            { b_components.line_col_lua, state.mode[2] },
        }
    end,
}

basic.lsp_diagnos = {
    name = 'diagnostic',
    hl_colors = {
        red = { 'red', 'NormalBg' },
        yellow = { 'yellow', 'NormalBg' },
        blue = { 'blue', 'NormalBg' },
    },
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                { lsp_comps.lsp_error({ format = '  %s', show_zero = true }), 'red' },
                { lsp_comps.lsp_warning({ format = '  %s', show_zero = true }), 'yellow' },
                { lsp_comps.lsp_hint({ format = '  %s', show_zero = true }), 'blue' },
            }
        end
        return { ' ', 'red' }
    end,
}

basic.git = {
    name = 'git',
    width = width_breakpoint,
    hl_colors = {
        green = { 'green', 'NormalBg' },
        red = { 'red', 'NormalBg' },
        blue = { 'blue', 'NormalBg' },
    },
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                { git_comps.diff_added({ format = '  %s' }), 'green' },
                { git_comps.diff_removed({ format = '  %s' }), 'red' },
                { git_comps.diff_changed({ format = '  %s' }), 'blue' },
            }
        end
        return ''
    end,
}
local quickfix = {
    filetypes = { 'qf', 'Trouble' },
    active = {
        { '🚦 Quickfix ', { 'white', 'black' } },
        { helper.separators.slant_right, { 'black', 'black_light' } },
        {
            function()
                return vim.fn.getqflist({ title = 0 }).title
            end,
            { 'cyan', 'black_light' },
        },
        { ' Total : %L ', { 'cyan', 'black_light' } },
        { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
        { ' ', { 'InactiveFg', 'InactiveBg' } },
        basic.divider,
        { helper.separators.slant_right, { 'InactiveBg', 'black' } },
        { '🧛 ', { 'white', 'black' } },
    },
    always_active = true,
    show_last_status = true
}

local explorer = {
    filetypes = { 'fern', 'NvimTree', 'lir' },
    active = {
        { '  ', { 'white', 'magenta_b' } },
        { helper.separators.slant_right, { 'magenta_b', 'NormalBg' } },
        { b_components.divider, '' },
        { b_components.file_name(''), { 'NormalFg', 'NormalBg' } },
    },
    always_active = true,
    show_last_status = true
}

local default = {
    filetypes = { 'default' },
    active = {
        basic.section_a,
        basic.section_b,
        basic.section_c,
        basic.lsp_diagnos,
        { vim_components.search_count(), { 'cyan', 'NormalBg' } },
        basic.gps,
        basic.divider,
        basic.git,
        basic.section_x,
        basic.section_y,
        basic.section_z,
    },
    inactive = {
        { b_components.full_file_name, hl_list.Inactive },
        { b_components.divider, hl_list.Inactive },
        { b_components.line_col, hl_list.Inactive },
        { b_components.progress, hl_list.Inactive },
    },
}

windline.setup({
    colors_name = function(colors)
        local mod = function (c, value)
            if vim.o.background == 'light' then
                return HSL.rgb_to_hsl(c):tint(value):to_rgb()
            end
            return HSL.rgb_to_hsl(c):shade(value):to_rgb()
        end

        colors.magenta_a = colors.magenta
        colors.magenta_b = mod(colors.magenta,0.5)
        colors.magenta_c = mod(colors.magenta,0.7)

        colors.yellow_a = colors.yellow
        colors.yellow_b = mod(colors.yellow,0.5)
        colors.yellow_c = mod(colors.yellow,0.7)

        colors.blue_a = colors.blue
        colors.blue_b = mod(colors.blue,0.5)
        colors.blue_c = mod(colors.blue,0.7)

        colors.green_a = colors.green
        colors.green_b = mod(colors.green,0.5)
        colors.green_c = mod(colors.green,0.7)

        colors.red_a = colors.red
        colors.red_b = mod(colors.red,0.5)
        colors.red_c = mod(colors.red,0.7)

        return colors
    end,
    statuslines = {
        default,
        quickfix,
        explorer,
    },
})
-- telekasten
local home = vim.fn.expand("~/zettelkasten")
require('telekasten').setup({
    home         = home,
    take_over_my_home = true,
    auto_set_filetype = true,
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',
    image_subdir = "img",
    extension    = ".md",
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,
    template_new_note = home .. '/' .. 'templates/new_note.md',
    template_new_daily = home .. '/' .. 'templates/daily.md',
    template_new_weekly= home .. '/' .. 'templates/weekly.md',
    image_link_style = "markdown",
    plug_into_calendar = true,
    calendar_opts = {
        weeknm = 4,
        calendar_monday = 1,
        calendar_mark = 'left-fit',
    },
    close_after_yanking = false,
    insert_after_inserting = true,
    tag_notation = "#tag",
    command_palette_theme = "ivy",
    show_tags_theme = "ivy",
    subdirs_in_links = true,
    template_handling = "smart",
    new_note_location = "smart",
    rename_update_links = true,
})

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

-- 背景透明-放最后，覆盖主题
-- cmd 'hi NORMAL guibg=NONE ctermbg=NONE'
