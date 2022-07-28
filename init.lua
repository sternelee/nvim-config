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
-- local usercmd = vim.api.nvim_create_user_command

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

nvim_exec([[set guifont=VictorMono\ NF:h18]], false)

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  -- execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
  execute('!git clone --depth 1 https://hub.fastgit.xyz/wbthomason/packer.nvim.git '.. install_path)
end

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/glepnir/nvim-lua-guide-zh
-- https://github.com/neovim/neovim/wiki/Related-projects#Plugins
-- https://github.com/ecosse3/nvim
-- using :source % or :luafile %
-- log: nvim -V9myNvim.log
cmd [[packadd packer.nvim]]
local packer = require('packer')
-- packer.init({
--   git = {
--     default_url_format = "https://hub.xn--p8jhe.tw/%s"
--   }
-- })
packer.startup({function()
  use 'wbthomason/packer.nvim'
  use {'lewis6991/impatient.nvim'}
  use 'nathom/filetype.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use {'antoinemadec/FixCursorHold.nvim', opt = true, event = 'BufRead'}
  -- 状态栏
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'goolord/alpha-nvim'
  use 'SmiteshP/nvim-gps'
  -- use {
  --     "SmiteshP/nvim-navic",
  --     requires = "neovim/nvim-lspconfig"
  -- }
  -- git相关
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  -- use {'lambdalisue/gina.vim', opt = true, cmd = {'Gina'}}
  use {'akinsho/git-conflict.nvim', opt = true, cmd = {'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth', 'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict'}, config = function()
    require('git-conflict').setup()
  end}
  use {'f-person/git-blame.nvim', event = 'BufRead'}-- 显示git message
  use {'rbong/vim-flog', opt = true, cmd = {'Flog'}}
  use {'sindrets/diffview.nvim', opt = true, cmd = {'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles'},
    config = function ()
      require('diffview').setup()
    end
  }
  -- 语法高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', lock = true }
  use {'nvim-treesitter/nvim-treesitter-refactor', opt = true, event = 'InsertEnter', config = function() require('nvim-treesitter-refactor').init() end}
  use {'nvim-treesitter/nvim-treesitter-textobjects', opt = true, event = 'InsertEnter'}
  -- use {
  --   'romgrk/nvim-treesitter-context',
  --   opt = true,
  --   event = 'BufRead',
  --   config = function()
  --     require('treesitter-context').setup {}
  --   end} -- or nvim_context_vt
  -- use {'haringsrob/nvim_context_vt', event = 'BufRead', config = function() require('nvim_context_vt'):setup() end}
  use {'nvim-treesitter/playground', opt = true, cmd = {'TSPlaygroundToggle'}}
  -- use "ziontee113/syntax-tree-surfer"
  use {'folke/twilight.nvim', opt = true, cmd = {'Twilight'}, config = function() require('twilight'):setup() end}
  use 'norcalli/nvim-colorizer.lua' -- 色值高亮
  -- theme 主题 -- https://vimcolorschemes.com/
  -- use 'bluz71/vim-nightfly-guicolors'
  -- use {'sternelee/bogsterish.nvim', requires='rktjmp/lush.nvim'}
  use 'RRethy/nvim-base16'
  use 'Mofiqul/vscode.nvim'
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
  -- use {'fedepujol/move.nvim', opt = true, event = 'BufRead'}
  -- use {'kevinhwang91/nvim-hlslens', opt = true, event = 'BufRead'} -- 显示高亮的按键位置
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
  use { "johmsalas/text-case.nvim",
    opt = true,
    event = 'InsertEnter',
    config = function()
      require('textcase').setup {}
    end
  }
  -- 语法建议
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- "ChristianChiarulli/lsp-inlay-hints"
  }
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'b0o/schemastore.nvim' -- json server
  -- use {'github/copilot.vim', opt = true, event = 'BufRead'}
  use { 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets' } }
  use {'hrsh7th/nvim-cmp', requires = {
    {'petertriho/cmp-git'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'saadparwaiz1/cmp_luasnip'},
    {'rafamadriz/friendly-snippets'},
    {'hrsh7th/cmp-calc'},
    {'hrsh7th/cmp-emoji'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    -- {'hrsh7th/cmp-cmdline'},
    -- {'octaltree/cmp-look'}, -- 太多了
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
  use {'kevinhwang91/nvim-bqf', ft = 'qf', event = 'BufRead', config = function() require('bqf'):setup() end}
  -- use {'folke/trouble.nvim', event = 'BufRead', config = function() require('trouble'):setup() end}
  use {'glepnir/lspsaga.nvim', branch = 'main'}
  use {
    'weilbith/nvim-code-action-menu',
    opt = true,
    cmd = 'CodeActionMenu',
  }
  use 'onsails/lspkind-nvim'
  -- use {'simrat39/symbols-outline.nvim', opt = true, cmd = {'SymbolsOutline'}} -- use lspsaga
  use {'kosayoda/nvim-lightbulb', opt = true, event = 'BufRead', config = 'vim.cmd[[autocmd CursorHold,CursorHoldI * :lua require"nvim-lightbulb".update_lightbulb()]]'}
  -- use 'ray-x/lsp_signature.nvim'
  use {'j-hui/fidget.nvim', event = 'BufRead', config = function() require('fidget'):setup() end}
  -- rust
  -- use {'simrat39/rust-tools.nvim',
  --   ft = 'rust',
  --   event = 'BufRead',
  --   config = function()
  --     require('rust-tools'):setup{
  --       tools = {
  --         autoSetHints = true,
  --         runnables = { use_telescope = true },
  --         inlay_hints = { show_parameter_hints = true },
  --         hover_actions = { auto_focus = true }
  --       }
  --     }
  --   end}
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
  -- use {
  --   'NTBBloodbath/rest.nvim',
  --   ft = 'http',
  --   requires = {"nvim-lua/plenary.nvim" },
  --   config = function()
  --     require'rest-nvim'.setup() end}
  use {'pechorin/any-jump.vim', opt = true, cmd = {'AnyJump'}}
  use {
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    event = 'BufRead package.json',
    config = function()
      require('package-info').setup()
    end}
  use {'editorconfig/editorconfig-vim', opt = true, event = 'BufRead'}
  use {
    'rmagatti/goto-preview',
    opt = true,
    evnet = 'BufRead',
    config = function()
      require('goto-preview').setup {}
    end
  }
  -- use {'napmn/react-extract.nvim', config = function() require('react-extract').setup() end} -- 重构react组件
  -- use {
  --   'willchao612/vim-diagon',
  --   opt = true,
  --   ft = 'markdown'
  -- }
  use {'yardnsm/vim-import-cost', opt = true, cmd = 'ImportCost'}
  use {
    "amrbashir/nvim-docs-view",
    opt = true,
    cmd = { "DocsViewToggle" },
    config = function()
      require("docs-view").setup {
        position = "right",
        width = vim.api.nvim_get_option("columns") / 3,
      }
    end
  }
  -- 方便操作
  use {
    "max397574/better-escape.nvim",
    opt = true,
    event = 'InsertEnter',
    config = function()
      require("better_escape").setup()
    end,
  }
  use {'iamcco/markdown-preview.nvim', opt = true, ft = 'markdown', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  -- use {'AndrewRadev/switch.vim', opt = true, event = 'BufRead', cmd = {'Switch'}}
  use {'AndrewRadev/splitjoin.vim', opt = true, event = 'BufRead'}
  -- use {'tpope/vim-speeddating', opt = true, event = 'BufRead'}
  use {'nacro90/numb.nvim', opt = true, event = 'BufRead', config = function()
    require('numb').setup()
  end}
  -- use {'mattn/emmet-vim'} -- use emmet_ls
  use {'tpope/vim-eunuch', opt = true, cmd = {'Delete', 'Mkdir', 'Rename'}}
  -- use {'gennaro-tedesco/nvim-peekup', event = 'InsertEnter'} -- 查看历史的复制和删除的寄存器,快捷键 ""
  use {'voldikss/vim-translator', opt = true, cmd = {'Translate'}} -- npm install fanyi -g 安装翻译
  use {'numToStr/Comment.nvim', requires = {'JoosepAlviste/nvim-ts-context-commentstring'}}
  use {'ZhiyuanLck/smart-pairs', event = 'InsertEnter', config = function() require('pairs'):setup() end}
  use {'windwp/nvim-ts-autotag', event = 'InsertEnter'}
  use {'machakann/vim-sandwich', event = 'InsertEnter'}
  use {'chentoast/marks.nvim', event = 'BufRead',
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
  -- use {'hoschi/yode-nvim', opt = true, event = 'BufRead', config = function () require('yode-nvim').setup({}) end}
  -- use {'anuvyklack/hydra.nvim', requires = 'anuvyklack/keymap-layer.nvim', config = function () require('modules.hydra') end} -- 增强的重复操作
  use 'folke/todo-comments.nvim'
  use {
    'danymat/neogen',
    event = 'InsertEnter',
    config = function()
      require'neogen'.setup {
          enabled = true
      }
    end} -- 方便写注释
  use 'ntpeters/vim-better-whitespace'
  use {'ThePrimeagen/vim-be-good', opt = true, cmd = 'VimBeGood'}
  use 'mhartington/formatter.nvim'
  use 'rcarriga/nvim-notify'
  use {'metakirby5/codi.vim', opt = true, cmd = {'Codi'}}
  -- use {'brooth/far.vim', event = 'InsertEnter'} -- or nvim-pack/nvim-spectre 全局替换
  use {'nvim-pack/nvim-spectre',
    opt = true,
    event = 'InsertEnter',
    config = function()
      require('spectre').setup()
    end
  }
  use {'tpope/vim-repeat', event = 'InsertEnter'}
  use {'arjunmahishi/run-code.nvim', event = 'BufRead',
    config = function()
      require('run-code').setup{}
    end
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
  use {'sidebar-nvim/sidebar.nvim', opt = true, cmd = {'SidebarNvimToggle'},
    config = function()
      local sidebar = require("sidebar-nvim")
      sidebar.setup({
        open = false,
        initial_width = 30,
        bindings = { ["q"] = function() sidebar.close() end },
        sections = {
            "datetime",
            "git",
            "diagnostics",
            -- require("dap-sidebar-nvim.breakpoints")
        },
        dap = {
            breakpoints = {
                icon = "🔍"
            }
        }
      })
    end
  }
  -- use {
  -- 	'xeluxee/competitest.nvim',
  -- 	requires = 'MunifTanjim/nui.nvim',
  -- 	config = function() require'competitest'.setup() end
  -- } -- 竞技编程
  use {"wakatime/vim-wakatime", opt = true, event = "BufRead"}

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
opt('o', 'writebackup', false)
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
opt('o', 'history', 500)
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
vim.opt.fillchars:append('fold:•')

nvim_exec([[
filetype plugin on
filetype indent on
]], false)

--mappings
local function map(mode, lhs, rhs)
  local options = {noremap = true}
  remap(mode, lhs, rhs, options)
end

g.mapleader = " "                                                     --leader
g.maplocalleader = ","
map('n', '<C-p>', '"0p')
map('v', '<C-p>', '"0p')
map('i', '<C-v>', '"0p')
-- map('i', 'jk', '<esc>')                                               --jk to exit
-- map('c', 'jk', '<C-C>')
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
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
map('n', '<leader>m', '<cmd>Telescope marks<CR>')
-- map('n', '<leader>rb', '<cmd>ReachOpen buffers<CR>')
-- map('n', '<leader>rm', '<cmd>ReachOpen marks<CR>')
map('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>\'', '<cmd>Telescope resume<CR>')
map('n', '<leader>s', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>p', '<cmd>Telescope commands<CR>')
map('n', 'ft', '<cmd>Telescope treesitter<CR>')
map('n', 'fc', '<cmd>Telescope commands<CR>')
map('n', 'fe', '<cmd>Telescope file_browser<CR>')                      --nvimtree
map('n', 'fp', '<cmd>Telescope projects<CR>')                      --nvimtree
map('n', '<leader>ns', '<cmd>lua require("package-info").show()<CR>')
map('n', '<leader>np', '<cmd>lua require("package-info").change_version()<CR>')
map('n', '<leader>ni', '<cmd>lua require("package-info").install()<CR>')
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')                      --nvimtree
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>tb', '<cmd>SidebarNvimToggle<CR>')
map('n', '<leader>tl', '<cmd>Twilight<CR>')
map('n', '<leader>tw', '<cmd>Translate<CR>')
-- nvim-lsp-ts-utils
map('n', '<leader>to', '<cmd>TSLspOrganize<CR>')
map('n', '<leader>tn', '<cmd>TSLspRenameFile<CR>')
map('n', '<leader>ti', '<cmd>TSLspImportAll<CR>')
map('n', '<leader>sl', '<cmd>SessionLoad<CR>')
map('n', '<leader>ss', '<cmd>SessionSave<CR>')
map('n', 'st', '<cmd>LSoutlineToggle<CR>')
map('n', '<leader>td', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>tD', '<cmd>DiffviewClose<CR>')
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
map('n', 'gn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
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

-- dapui
-- map('n', '<leader>td', '<cmd>lua require("dapui").toggle()<CR>')

-- goto-preview
map('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
map('n', 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>')
map('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')

-- copilot 要收钱了
-- g.copilot_no_tab_map = true
-- cmd [[
--   imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- ]]

-- spectre
map('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>')
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
map('v', '<leader>s', '<cmd>lua require("spectre").open_visual()<CR>')
map('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')

-- move.nvim
-- map('n', '<M-j>', '<cmd>MoveLine(1)<CR>')
-- map('n', '<M-j>', '<cmd>MoveLine(1)<CR>')
-- map('n', '<M-k>', '<cmd>MoveLine(-1)<CR>')
-- map('v', '<M-j>', '<cmd>MoveBlock(1)<CR>')
-- map('v', '<M-j>', '<cmd>MoveBlock(-1)<CR>')
-- map('n', '<M-l>', '<cmd>MoveHChar(1)<CR>')
-- map('n', '<M-h>', '<cmd>MoveHChar(-1)<CR>')
-- map('v', '<M-l>', '<cmd>MoveHBlock(1)<CR>')
-- map('n', '<M-h>', '<cmd>MoveHBlock(1)<CR>')

-- LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD', '<cmd>Lspsaga preview_definition<CR>')
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', 'gh', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
-- map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
-- map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
map('n', '<space>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>')

map('n', '<leader>l', '<cmd>Lspsaga lsp_finder<CR>')
map('n', 'ga', '<cmd>Lspsaga code_action<CR>')
map('x', 'gA', '<cmd>Lspsaga range_code_action<CR>')
map('n', 'gam', '<cmd>CodeActionMenu<CR>')
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
map('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>')
map('n', 'gr', '<cmd>Lspsaga rename<CR>')
map('n', 'gi', '<cmd>Lspsaga implement<CR>')
map('n', 'gC', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
map('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')
map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
map('n', '<A-d>', '<cmd>Lspsaga open_floaterm custom_cli_command<CR>')
map('t', '<A-d>', '<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>')

cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]

cmd [[autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }]]
cmd [[autocmd FileType json lua require('cmp').setup.buffer { sources = { { name = 'npm', keyword_length = 3 } } }]]

autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
    end,
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
})

autocmd({"FileType"}, {
  pattern = "*.toml",
  callback = function()
    require('cmp').setup.buffer { sources = { { name = 'crates' } } }
  end,
  desc = "Add cmp source for toml",
})

autocmd({"FileType"}, {
  pattern = "*.json",
  callback = function()
    require('cmp').setup.buffer { sources = { { name = 'npm', keyword_length = 3 } } }
  end,
  desc = "Add cmp source for json",
})

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
for _, num in pairs(numbers) do
  map('n', '<leader>'..num, '<cmd>BufferGoto '..num..'<CR>')
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

--theme
cmd 'colorscheme vscode'

-- editorconfig-vim
g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*', ''}

local notify = require("notify")
vim.notify = notify

-- vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
--   local client = vim.lsp.get_client_by_id(ctx.client_id)
--   local lvl = ({
--     'ERROR',
--     'WARN',
--     'INFO',
--     'DEBUG',
--   })[result.type]
--   notify({ result.message }, lvl, {
--     title = 'LSP | ' .. client.name,
--     timeout = 10000,
--     keep = function()
--       return lvl == 'ERROR' or lvl == 'WARN'
--     end,
--   })
-- end

require'modules.telescope'

local noTsAndLSP = function (lang, bufnr)
  local n = vim.api.nvim_buf_line_count(bufnr)
  return  n > 10000 or n < 10 -- 大于一万行，或小于10行（可能是压缩的js文件）
end

--nvim treesitter 编辑大文件卡顿时最好关闭 highlight, rainbow, autotag
require('nvim-treesitter.configs').setup {
  ensure_installed = {"vue", "html", "javascript", "typescript", "scss", "json", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash", "http", "dot"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  disable_tokenziation_after_line = 10000,
  additional_vim_regex_highlighting = false,
  highlight = {
    enable = true,
    disable = noTsAndLSP
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    disable = noTsAndLSP
  },
  autotag = {
    enable = true,
    disable = noTsAndLSP
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    disable = noTsAndLSP
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
local luasnip = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noselect',
    border = true,
    scrollbar = true
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
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
    }),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-h>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', priority = 8 },
    { name = 'luasnip', priority = 7 },
    { name = 'buffer', option={keyword_length=2} },
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
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

-- cmdline在wsl容易卡死
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })
--
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

-- LSP config
require('lsp/config')

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
}

local on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local ts_utils = require("nvim-lsp-ts-utils")
    local init_options = require("nvim-lsp-ts-utils").init_options
    ts_utils.setup(init_options)
    ts_utils.setup_client(client)
  end

  if client.name == 'tailwindcss' then
    if client.server_capabilities.colorProvider then
      require"lsp/documentcolors".buf_attach(bufnr)
    end
  end

  -- if client.name ~= 'jsonls' then
  --   local msg = string.format("Language server %s started!", client.name)
  --   notify(msg, 'info', {title = 'LSP Notify', timeout = '100'})
  -- end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function setup_servers()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "html", "cssls", "tsserver", "emmet_ls", "eslint" },
    automatic_installation = true
  })

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
    -- autostart = false
    -- autostart = noTsAndLSP("", bufnr)
  }
  local lspconfig = require("lspconfig")
  local servers = { "sumneko_lua", "html", "cssls", "tsserver", "volar", "rust_analyzer", "emmet_ls", "eslint", "tailwindcss"} -- or volar

  for _, lsp in ipairs(servers) do
    if lsp == "jsonls" then
      opts.settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      }
    end
    if lsp == "tsserver" then
      opts.capabilities =require('lsp/tsserver').capabilities
    end
    if lsp == "sumneko_lua" then
      opts.settings = require('lsp/sumneko_lua').settings
    end
    if lsp == "eslint" then
      opts.settings =require('lsp/eslint').settings
      opts.handlers = {
        ['window/showMessageRequest'] = function(_, result, params) return result end
      }
    end
    if lsp == "tailwindcss" then
      opts.init_options = require('lsp/tailwindcss').init_options
      opts.settings = require('lsp/tailwindcss').settings
    end
    lspconfig[lsp].setup(opts)
   end
end

setup_servers()

require'nvim-tree'.setup {
  auto_reload_on_write = true,
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
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
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = false,
    timeout = 400,
  },
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
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
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
    },
    rust = {
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
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
    },
    WARN = { alt = { "WARNING" } },
    PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
  },
  highlight = {
    before = "", -- "fg" or "bg" or empty
    -- keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
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

require'modules.lualine'
require'modules.saga'
-- vim.o.winbar = "%{%v:lua.require'modules.winbar'.eval()%}"

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
]]
