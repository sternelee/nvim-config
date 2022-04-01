local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

g.neovide_transparency=0.98
g.neovide_cursor_vfx_mode = "sonicboom"

nvim_exec([[set guifont=VictorMono\ NF:h18]], false)

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/glepnir/nvim-lua-guide-zh
-- https://github.com/neovim/neovim/wiki/Related-projects#Plugins
-- using :source % or :luafile %
cmd [[packadd packer.nvim]]
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nathom/filetype.nvim'
  -- 状态栏
  use 'romgrk/barbar.nvim'
  use {'windwp/windline.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
  use 'kyazdani42/nvim-tree.lua'
  use 'goolord/alpha-nvim'
  use 'SmiteshP/nvim-gps'
  use 'sidebar-nvim/sidebar.nvim'
  -- git相关
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  use {'lambdalisue/gina.vim'}
  use {'f-person/git-blame.nvim', event = 'BufRead'}-- 显示git message
  use {'rbong/vim-flog', event = 'InsertEnter'}
  use {'junegunn/gv.vim', event = 'InsertEnter'}
  -- 语法高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/nvim-treesitter-refactor', config = function() require('nvim-treesitter-refactor').init() end}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- use {
  --   'romgrk/nvim-treesitter-context',
  --   config = function()
  --     require('treesitter-context').setup {}
  --   end} -- 使用 nvim_context_vt
  use {'haringsrob/nvim_context_vt', event = 'BufRead', config = function() require('nvim_context_vt'):setup() end}
  use 'nvim-treesitter/playground'
  -- use {
  --   'lewis6991/spellsitter.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     require('spellsitter').setup()
  --   end}
  use {'folke/twilight.nvim', event = 'BufRead', config = function() require('twilight'):setup() end}
  use 'norcalli/nvim-colorizer.lua' -- 色值高亮
  -- use {'ellisonleao/glow.nvim', event = 'BufRead'} -- markdown 文件预览
  -- theme 主题 -- https://vimcolorschemes.com/
  use 'bluz71/vim-nightfly-guicolors'
  use 'ellisonleao/gruvbox.nvim'
  use 'Mofiqul/vscode.nvim'
  use {'catppuccin/nvim', as = 'catppuccin'}
  use {'amazingefren/bogsterish.nvim', requires='rktjmp/lush.nvim'}
  -- 显示导航线
  use {'lukas-reineke/indent-blankline.nvim', event = 'BufRead',
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true
      }
    end}
  use {'mg979/vim-visual-multi', event = 'InsertEnter'}
  use {'kevinhwang91/nvim-hlslens', event = 'BufRead'} -- 显示高亮的按键位置
  -- use {'m-demare/hlargs.nvim', event = 'BufRead',
  --   config = function ()
  --     require('hlargs').setup{}
  --   end} -- 和codi冲突
  use {'phaazon/hop.nvim', event = 'BufRead', config = function() require('hop'):setup() end}
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-packer.nvim'
  -- 语法建议
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'b0o/schemastore.nvim' -- json server
  use 'github/copilot.vim'
  use {'hrsh7th/nvim-cmp', branch = 'dev', requires = {
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
    -- {'hrsh7th/cmp-cmdline'},
    {'octaltree/cmp-look'}, -- 太多了
    {'dmitmel/cmp-digraphs'},
    {'tzachar/cmp-tabnine', run='./install.sh'}, -- 内存占用太大
    -- {'ray-x/cmp-treesitter'},
    -- {'f3fora/cmp-spell'}, -- look更好
  }}
  use {'ThePrimeagen/refactoring.nvim', config = function () require('refactoring').setup() end}
  -- 语法提示
  use {'kevinhwang91/nvim-bqf', ft = 'qf', event = 'BufRead', config = function() require('bqf'):setup() end}
  use {'tami5/lspsaga.nvim'}
  use {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  }
  use 'onsails/lspkind-nvim'
  use {'liuchengxu/vista.vim',opt = true, cmd = {'Vista'}}
  use 'kosayoda/nvim-lightbulb'
  -- use 'ray-x/lsp_signature.nvim'
  use {'j-hui/fidget.nvim', event = 'BufRead', config = function() require('fidget'):setup() end}
  -- 方便操作
  use 'tpope/vim-eunuch'
  use {'gennaro-tedesco/nvim-peekup', event = 'InsertEnter'} -- 查看历史的复制和删除的寄存器,快捷键 ""
  use 'voldikss/vim-translator' -- npm install fanyi -g 安装翻译
  use {'numToStr/Comment.nvim', requires = {'JoosepAlviste/nvim-ts-context-commentstring'}}
  use {'ZhiyuanLck/smart-pairs', event = 'InsertEnter', config = function() require('pairs'):setup() end}
  use {'windwp/nvim-ts-autotag', event = 'InsertEnter'}
  use {'machakann/vim-sandwich', event = 'InsertEnter'}
  use {'jdhao/better-escape.vim', event = 'InsertEnter'} -- 快速按jk退出编辑态
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
  use 'p00f/nvim-ts-rainbow' -- 彩虹匹配
  use {'pechorin/any-jump.vim', event = 'InsertEnter'}
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
  use {'metakirby5/codi.vim', event = 'InsertEnter'}
  use {'turbio/bracey.vim', cmd = 'Bracey'}
  -- use {'skywind3000/asyncrun.vim', event = 'InsertEnter'}
  -- use {'skywind3000/asynctasks.vim', event = 'InsertEnter'}
  use { 'bennypowers/nvim-regexplainer',
    event = 'BufRead',
    config = function() require'regexplainer'.setup()  end,
    requires = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    }}
  use {
    'rcarriga/nvim-dap-ui',
    event = 'InsertEnter',
    requires = { 'mfussenegger/nvim-dap', 'Pocco81/DAPInstall.nvim', 'sidebar-nvim/sections-dap', 'theHamsta/nvim-dap-virtual-text'},
    config = function()
      require("nvim-dap-virtual-text").setup()
      require("dapui").setup()
      local dap_install = require("dap-install")
      dap_install.setup({
      	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
      })
    end}
  use {
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    event = 'BufRead package.json',
    config = function()
      require('package-info').setup()
    end}
  -- rust
  use {'simrat39/rust-tools.nvim', event = 'BufRead', config = function() require('rust-tools'):setup() end}
  use {'Saecki/crates.nvim',
     event = { "BufRead Cargo.toml" },
    config = function()
        require('crates').setup()
    end}
  use {'David-Kunz/cmp-npm',
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
  use 'nanotee/sqls.nvim'
  -- use {'brooth/far.vim', event = 'InsertEnter'} -- or nvim-pack/nvim-spectre 全局替换
  use 'windwp/nvim-spectre'
  use {'tpope/vim-repeat', event = 'InsertEnter'}
  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {}
    end
  }
  -- use {'Pocco81/AutoSave.nvim', event = 'InsertEnter',
  --   config = function()
  --     require('autosave').setup{
  --       enabled = true,
  --       execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
  --       events = {"InsertLeave"},
  --       conditions = {
  --           exists = true,
  --           filename_is_not = {},
  --           filetype_is_not = {},
  --           modifiable = true
  --       },
  --       write_all_buffers = false,
  --       on_off_commands = true,
  --       clean_command_line_interval = 0,
  --       debounce_delay = 600
  --     }
  --   end
  -- }
  use {
    'rmagatti/goto-preview',
    evnet = 'BufRead',
    config = function()
      require('goto-preview').setup {}
    end
  }
  use {
    'willchao612/vim-diagon',
    ft = 'markdown'
  }
  -- use {
  -- 	'xeluxee/competitest.nvim',
  -- 	requires = 'MunifTanjim/nui.nvim',
  -- 	config = function() require'competitest'.setup() end
  -- } -- 竞技编程

end)

--settings
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
cmd 'hi NORMAL guibg=#2f334d'
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'scrolloff', 3 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'clipboard', 'unnamed')                      -- 与系统剪切板相通
opt('o', 'pumblend', 25 )
opt('o', 'scrolloff', 2 )
opt('o', 'tabstop', 2)
opt('o', 'shiftwidth', 2)
opt('o', 'softtabstop', 2)
opt('o', 'swapfile', false )
opt('o', 'showmode', false )
opt('o', 'background', 'dark' )
opt('o', 'backup', false )
opt('w', 'number', true)                              -- Print line number
opt('o', 'lazyredraw', true)
opt('o', 'signcolumn', 'yes')
opt('o', 'mouse', 'a')
opt('o', 'cmdheight', 1)
opt('o', 'wrap', true)
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
opt('o', 'laststatus', 2)
opt('o', 'cursorline', true)
opt('o', 'cursorcolumn', true)
opt('o', 'autowrite', true)
opt('o', 'autoindent', true)
opt('o', 'syntax', 'on')
opt('o', 'timeoutlen', 500)
opt('o', 'ttimeoutlen', 10)
opt('o', 'updatetime', 300)
opt('o', 'scrolljump', 6)
opt('o', 'undofile', true)
opt('o', 'showtabline', 2)

--set shortmess
vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.sessionoptions="buffers,help,tabpages"
vim.opt.fillchars:append('fold:•')

nvim_exec([[
filetype on
filetype plugin on
filetype indent on
]], false)

--mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  remap(mode, lhs, rhs, options)
end

g.did_load_filetypes = 1
g.mapleader = " "                                                     --leader
g.maplocalleader = ","
-- map('n', 'x', '"_x')
-- map('n', 'X', '"_X')
-- map('n', 'd', '"_d')  --- 删除不写剪切板
-- map('n', 'dd', '"_dd')
-- map('n', 'D', '"_D')
-- map('v', 'd', '"_d')
-- map('v', 'dd', '"_dd')
map('i', 'jk', '<esc>')                                               --jk to exit
map('c', 'jk', '<C-C>')
map('n', ';', ':')                                                     --semicolon to enter command mode
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
map('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>')                      --nvimtree
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>tb', '<cmd>SidebarNvimToggle<CR>')
map('n', '<leader>tl', '<cmd>Twilight<CR>')
map('n', '<leader>tw', '<cmd>Translate<CR>')
map('n', '<leader>th', '<cmd>lua require("hlargs").toggle()<CR>')
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
map('n', '<c-o>', '<cmd>Lspsaga open_floaterm<CR>')
map('n', '<c-n>', '<cmd>Lspsaga close_floaterm<CR>')
map('n', 'gb', '<cmd>BufferPick<CR>')
map('n', 'gp', '<cmd>bprevious<CR>')
map('n', 'gn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Gina add .<CR>')
map('n', '<leader>gm', '<cmd>Gina commit<CR>')
map('n', '<leader>gs', '<cmd>Gina status<CR>')
map('n', '<leader>gu', '<cmd>Gina pull<CR>')
map('n', '<leader>gh', '<cmd>Gina push<CR>')
map('n', '<leader>gl', '<cmd>Gina log<CR>')
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

-- spectre
map('n', '<leader>rp', '<cmd>lua require("spectre").open()<CR>')
map('n', '<leader>rf', '<cmd>lua require("spectre").open_file_search()<CR>')
map('n', '<leader>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')

-- dapui
map('n', '<leader>td', '<cmd>lua require("dapui").toggle()<CR>')

-- goto-preview
map('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
map('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
map('n', 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>')
map('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')

cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]
cmd [[autocmd CursorHold,CursorHoldI * :lua require'nvim-lightbulb'.update_lightbulb()]]

cmd[[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  augroup END
]]

cmd [[autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }]]
cmd [[autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'npm', keyword_length = 3 } } }]]

-- https://github-wiki-see.page/m/neovim/nvim-lspconfig/wiki/UI-customization
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
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

nvim_exec([[
let g:VM_maps = {}
let g:VM_default_mappings = 0
let g:VM_maps["Add Cursor Down"] = '<A-j>'
let g:VM_maps["Add Cursor Up"] = '<A-k>'
let g:indent_blankline_char_highlight_list = ['|', '¦', '┆', '┊']
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

vim.opt.list = true
vim.opt.listchars:append("space:⋅")


--theme
g.vscode_style = "dark"
g.vscode_italic_comment = 1
require'catppuccin'.setup{}
g.moonflyIgnoreDefaultColors = 1
g.nightflyCursorColor = 1
g.nightflyNormalFloat = 1

cmd 'colorscheme bogsterish'

local notify = require("notify")
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
    timeout = 10000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close
      }
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
    },
  },
}

require'telescope'.load_extension('file_browser')
require'telescope'.load_extension('notify')
require'telescope'.load_extension('refactoring')
require'telescope'.load_extension('packer')

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
    { name = 'spell' },
    -- { name = 'cmp_tabnine' },
    { name = 'cmp_git' },
    { name = 'copilot' },
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
  -- buf_set_keymap('n', 'ga', '<cmd>CodeActionMenu<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Lspsaga implement<CR>', opts)
  buf_set_keymap('n', 'gE', '<cmd>Lspsaga preview_definition<CR>', opts)
  buf_set_keymap('n', 'gc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)


  if client.name == 'sqls' then
    require('sqls').on_attach(client, bufnr)
  end

  if client.name == 'tsserver' then
    local ts_utils = require("nvim-lsp-ts-utils")
    local init_options = require("nvim-lsp-ts-utils").init_options
    ts_utils.setup(init_options)
    ts_utils.setup_client(client)
  end

  -- if client.name ~= 'jsonls' then
    -- local msg = string.format("Language server %s started!", client.name)
    -- notify(msg, 'info', {title = 'LSP Notify', timeout = '300'})
    -- require'lsp_signature'.on_attach({
    --   bind = true,
    --   handler_opts = {
    --     border = "rounded"
    --   }
    -- }, bufnr)
  -- end

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
require'lspkind'.init()

require'nvim-tree'.setup {
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
    side = 'left',
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


require'alpha'.setup(require'alpha.themes.startify'.opts)

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

_G.whitespace_disabled_file_types = {
    'lsp-installer',
    'lspinfo',
    'TelescopePrompt',
    'dashboard',
    'alpha'
}
function _G.whitespace_visibility(file_types)
    local better_whitespace_status = 1
    local current_file_type = vim.api.nvim_eval('&ft')
    for k,v in ipairs(file_types) do
        if current_file_type == "" or current_file_type == v then
            better_whitespace_status = 0
        end
    end

    if better_whitespace_status == 0 then
        vim.cmd('execute "DisableWhitespace"')
    else
        vim.cmd('execute "EnableWhitespace"')
    end
end

cmd('autocmd BufEnter * lua whitespace_visibility(whitespace_disabled_file_types)')
cmd('autocmd FileType dashboard execute "DisableWhitespace" | autocmd BufLeave <buffer> lua whitespace_visibility(whitespace_disabled_file_types)')

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

local sidebar = require("sidebar-nvim")
sidebar.setup({
  open = false,
  initial_width = 30,
  bindings = { ["q"] = function() sidebar.close() end },
  sections = {
      "datetime",
      "git",
      "diagnostics",
      require("dap-sidebar-nvim.breakpoints")
  },
  dap = {
      breakpoints = {
          icon = "🔍"
      }
  }
})

-- windline config
local windline = require('windline')
local helper = require('windline.helpers')
local sep = helper.separators
local vim_components = require('windline.components.vim')

local b_components = require('windline.components.basic')
local state = _G.WindLine.state

local lsp_comps = require('windline.components.lsp')
local git_comps = require('windline.components.git')
local gps = require("nvim-gps")
gps.setup()

b_components.gps = {
  function()
    if gps.is_available() then
      return gps.get_location()
    end
    return ''
  end,
  {"white", "black"}
}

local hl_list = {
    Black = { 'white', 'black' },
    White = { 'black', 'white' },
    Inactive = { 'InactiveFg', 'InactiveBg' },
    Active = { 'ActiveFg', 'ActiveBg' },
}
local basic = {}

basic.divider = { b_components.divider, '' }
basic.file_name_inactive = { b_components.full_file_name, hl_list.Inactive }
basic.line_col_inactive = { b_components.line_col, hl_list.Inactive }
basic.progress_inactive = { b_components.progress, hl_list.Inactive }

basic.vi_mode = {
    name = 'vi_mode',
    hl_colors = {
        Normal = { 'black', 'red', 'bold' },
        Insert = { 'black', 'green', 'bold' },
        Visual = { 'black', 'yellow', 'bold' },
        Replace = { 'black', 'blue_light', 'bold' },
        Command = { 'black', 'magenta', 'bold' },
        NormalBefore = { 'red', 'black' },
        InsertBefore = { 'green', 'black' },
        VisualBefore = { 'yellow', 'black' },
        ReplaceBefore = { 'blue_light', 'black' },
        CommandBefore = { 'magenta', 'black' },
        NormalAfter = { 'white', 'red' },
        InsertAfter = { 'white', 'green' },
        VisualAfter = { 'white', 'yellow' },
        ReplaceAfter = { 'white', 'blue_light' },
        CommandAfter = { 'white', 'magenta' },
    },
    text = function()
        return {
            { sep.left_rounded, state.mode[2] .. 'Before' },
            { state.mode[1] .. ' ', state.mode[2] },
            { sep.left_rounded, state.mode[2] .. 'After' },
        }
    end,
}

basic.lsp_diagnos = {
    name = 'diagnostic',
    hl_colors = {
        red = { 'red', 'black' },
        yellow = { 'yellow', 'black' },
        blue = { 'blue', 'black' },
    },
    width = 90,
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                { lsp_comps.lsp_error({ format = '  %s' }), 'red' },
                { lsp_comps.lsp_warning({ format = '  %s' }), 'yellow' },
                { lsp_comps.lsp_hint({ format = '  %s' }), 'blue' },
            }
        end
        return ''
    end,
}

basic.file = {
    name = 'file',
    hl_colors = {
        default = hl_list.White,
    },
    text = function()
        return {
            {b_components.cache_file_icon({ default = '' }), 'default'},
            { ' ', 'default' },
            { b_components.cache_file_name('[No Name]', 'unique') },
            { b_components.file_modified(' ')},
            { b_components.cache_file_size()},
        }
    end,
}

basic.right = {
    hl_colors = {
        sep_before = { 'black_light', 'black' },
        sep_after = { 'black_light', 'black' },
        text = { 'white', 'black_light' },
    },
    text = function()
        return {
            { sep.left_rounded, 'sep_before' },
            { 'l/n', 'text' },
            { b_components.line_col_lua },
            { '' },
            { b_components.progress_lua },
            { sep.right_rounded, 'sep_after' },
        }
    end,
}
basic.git = {
    name = 'git',
    width = 90,
    hl_colors = {
        green = { 'green', 'black' },
        red = { 'red', 'black' },
        blue = { 'blue', 'black' },
    },
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                { ' ' },
                { git_comps.diff_added({ format = ' %s' }), 'green' },
                { git_comps.diff_removed({ format = '  %s' }), 'red' },
                { git_comps.diff_changed({ format = ' 柳%s' }), 'blue' },
            }
        end
        return ''
    end,
}

local default = {
    filetypes = { 'default' },
    active = {
        { ' ', hl_list.Black },
        basic.vi_mode,
        basic.file,
        { vim_components.search_count(), { 'red', 'white' } },
        { sep.right_rounded, hl_list.Black },
        basic.lsp_diagnos,
        basic.git,
        { ' ', hl_list.Black },
        b_components.gps,
        basic.divider,
        { git_comps.git_branch({ icon = '  ' }), { 'green', 'black' }, 90 },
        { ' ', hl_list.Black },
        basic.right,
        { ' ', hl_list.Black },
    },
    inactive = {
        basic.file_name_inactive,
        basic.divider,
        basic.divider,
        basic.line_col_inactive,
        { '', hl_list.Inactive },
        basic.progress_inactive,
    },
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
        { '  ', { 'white', 'black_light' } },
        { helper.separators.slant_right, { 'black_light', 'NormalBg' } },
        { b_components.divider, '' },
        { b_components.file_name(''), { 'NormalFg', 'NormalBg' } },
    },
    always_active = true,
    show_last_status = true
}

windline.setup({
    colors_name = function(colors)
        return colors
    end,
    statuslines = {
        default,
        explorer,
        quickfix,
    },
})

-- spectre
require'spectre'.setup{
    color_devicons = true,
    highlight = {
      ui = "String",
      search = "DiffChange",
      replace = "DiffDelete",
    },
    mapping = {
      ["toggle_line"] = {
        map = "t",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle current item",
      },
      ["enter_file"] = {
        map = "<cr>",
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = "goto current file",
      },
      ["send_to_qf"] = {
        map = "Q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix",
      },
      ["replace_cmd"] = {
        map = "c",
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = "input replace vim command",
      },
      ["show_option_menu"] = {
        map = "o",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option",
      },
      ["run_replace"] = {
        map = "R",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all",
      },
      ["change_view_mode"] = {
        map = "m",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode",
      },
      ["toggle_ignore_case"] = {
        map = "I",
        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
        desc = "toggle ignore case",
      },
      ["toggle_ignore_hidden"] = {
        map = "H",
        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
        desc = "toggle search hidden",
      },
    },
    find_engine = {
      ["rg"] = {
        cmd = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        options = {
          ["ignore-case"] = {
            value = "--ignore-case",
            icon = "[I]",
            desc = "ignore case",
          },
          ["hidden"] = {
            value = "--hidden",
            desc = "hidden file",
            icon = "[H]",
          },
        },
      },
      ["ag"] = {
        cmd = "ag",
        args = {
          "--vimgrep",
          "-s",
        },
        options = {
          ["ignore-case"] = {
            value = "-i",
            icon = "[I]",
            desc = "ignore case",
          },
          ["hidden"] = {
            value = "--hidden",
            desc = "hidden file",
            icon = "[H]",
          },
        },
      },
    },
    replace_engine = {
      ["sed"] = {
        cmd = "sed",
        args = sed_args,
      },
      options = {
        ["ignore-case"] = {
          value = "--ignore-case",
          icon = "[I]",
          desc = "ignore case",
        },
      },
    },
    default = {
      find = {
        cmd = "rg",
        options = { "ignore-case" },
      },
      replace = {
        cmd = "sed",
      },
    },
    replace_vim_cmd = "cdo",
    is_open_target_win = true, --open file on opener window
    is_insert_mode = false, -- start open panel on is_insert_mode
}
require('windline').add_status(
    require('spectre.state_utils').status_line()
)

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

-- telekasten 高亮
cmd [[
hi tkLink ctermfg=Blue cterm=bold,underline guifg=blue gui=bold,underline
hi tkBrackets ctermfg=gray guifg=gray

" for gruvbox
hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
hi tkBrackets ctermfg=gray guifg=gray

" real yellow
hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
" gruvbox
"hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

hi link CalNavi CalRuler
hi tkTagSep ctermfg=gray guifg=gray
hi tkTag ctermfg=175 guifg=#d3869B
]]


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
