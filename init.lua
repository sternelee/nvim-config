--make life easier
local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap

-- https://github.com/rohit-px2/nvui
-- nvui --ext_multigrid --ext_popupmenu --ext_cmdline --titlebar --detached
if g.nvui then
  cmd [[NvuiCmdCenterYPos 0.3]]
end

nvim_exec([[set guifont=VictorMono\ NF:h20]], false)
--Install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end
-- https://github.com/rockerBOO/awesome-neovim
--setup packer
cmd [[packadd packer.nvim]]
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nathom/filetype.nvim'
  -- 状态栏
  use {'famiu/feline.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'glepnir/dashboard-nvim'
  use 'SmiteshP/nvim-gps'
  -- git相关
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  -- use 'lambdalisue/gina.vim'
  use 'f-person/git-blame.nvim' -- 显示git message
  -- 语法高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  --[[ use {
    'romgrk/nvim-treesitter-context',
    config = function()
      require("treesitter-context").setup {}
    end
  } ]]
  use 'nvim-treesitter/playground'
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
    }
    end
  }
  use 'norcalli/nvim-colorizer.lua' -- 色值高亮
  use 'bluz71/vim-nightfly-guicolors'
  -- use 'sunjon/shade.nvim' -- 高亮当前tab窗口,但跟indent-blankline有冲突
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
    end
  }
  -- 导航finder操作
  use 'mg979/vim-visual-multi'
  use 'kevinhwang91/nvim-hlslens'
  use 'phaazon/hop.nvim'
  use 'ggandor/lightspeed.nvim'
  -- use { 'Yggdroot/LeaderF', run = ':LeaderfInstallCExtension' }
  -- use { 'gelguy/wilder.nvim', run = ':UpdateRemotePlugins'}
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
      require('telescope').load_extension('projects')
    end
  }
  -- 语法建议
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use {'hrsh7th/cmp-nvim-lsp', requires = {
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-vsnip'},
    {'ray-x/cmp-treesitter'},
    {'hrsh7th/cmp-calc'},
    {'hrsh7th/cmp-emoji'},
    -- {'f3fora/cmp-spell'},
    {'tzachar/cmp-tabnine', run='./install.sh'}
  }}
  -- 语法提示
  use 'folke/lsp-trouble.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'onsails/lspkind-nvim'
  use 'liuchengxu/vista.vim'
  use 'ray-x/lsp_signature.nvim'
  use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
    config = function()
      require'navigator'.setup()
    end
  }
  use 'kosayoda/nvim-lightbulb'
  --[[ use { 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = { 'jose-elias-alvarez/null-ls.nvim' },
      config = function ()
        require("null-ls").config {}
        require("lspconfig")["null-ls"].setup {}
      end
  } ]]
  -- snippet相关
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'rafamadriz/friendly-snippets'
  -- 方便操作
  use 'tpope/vim-eunuch'
  use 'gennaro-tedesco/nvim-peekup' -- 查看历史的复制和删除的寄存器,快捷键 ""
  use 'voldikss/vim-translator' -- npm install fanyi -g 安装翻译
  -- 注释
  use { 'b3nj5m1n/kommentary',
      config = function ()
        require('kommentary.config').use_extended_mappings()
      end
  }
  use "windwp/nvim-autopairs" -- 自动符号匹配
  use 'windwp/nvim-ts-autotag'
  -- use '9mm/vim-closer'
  use {
    "blackCauldron7/surround.nvim",
    config = function()
      require "surround".setup {}
    end
  }
  use 'folke/which-key.nvim' -- 提示leader按键
  use 'sindrets/diffview.nvim' -- diff对比
  use 'p00f/nvim-ts-rainbow' -- 彩虹匹配
  use {
      'folke/todo-comments.nvim',
      config = function ()
          require('todo-comments').setup{}
      end
  }
  -- use 'konfekt/fastfold' -- 性能更好的语法折叠
  use 'ThePrimeagen/vim-be-good'
  use 'mhartington/formatter.nvim'
  use {
    'NTBBloodbath/rest.nvim',
    config = function()
        require('rest-nvim').setup()
    end
  }
  use { "rcarriga/nvim-notify", config = 'vim.notify = require("notify")' }
  -- use 'metakirby5/codi.vim'
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}
  use 'simnalamburt/vim-mundo'
  --[[ use {
    "max397574/better-escape.nvim",
    event = 'InsertEnter',
    config = function()
      require("better_escape").setup()
    end,
  } ]]
  --[[ use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"},
    opt = true,
    config = function()
      require("dapui").setup()
    end
  } ]]
  -- use 'gennaro-tedesco/nvim-jqx'
  use 'rmagatti/auto-session'
  --[[ use({
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require('package-info').setup()
      end
  }) ]]
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
opt('o', 'clipboard', 'unnamed')
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
opt('o', 'wrap', false)
opt('o', 'relativenumber', true)
opt('o', 'hlsearch', true)
opt('o', 'inccommand', 'split')
opt('o', 'smarttab', true)
opt('o', 'incsearch', true)
opt('o', 'foldmethod', 'manual')
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
opt('o', 'scrolljump', 5)
opt('o', 'undofile', true)
-- opt('o', 'undodir', '~/.vim/undo')

--set shortmess
vim.o.shortmess = vim.o.shortmess .. "c"

nvim_exec([[
filetype on
filetype plugin on
filetype indent on
command! -nargs=0 Dap :lua require("dapui").toggle()
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
map('i', 'jk', '<esc>')                                               --jk to exit
map('c', 'jk', '<C-C>')
map('n', ';', ':')                                                     --semicolon to enter command mode
map('n', 'j', 'gj')                                                    --move by visual line not actual line
map('n', 'k', 'gk')
map('n', 'q', '<cmd>q<CR>')
map('n', '<leader>w', '<cmd>HopWord<CR>')                              --easymotion/hop
map('n', '<leader>l', '<cmd>HopLine<CR>')
map('n', '<leader>/', '<cmd>HopPattern<CR>')
map('n', '<leader>p', '<cmd>Telescope<CR>')                   --fuzzy
map('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>')                   --fuzzy
map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fs', '<cmd>Telescope treesitter<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands<CR>')
map('n', '<leader>fp', '<cmd>Telescope project<CR>')
map('n', '<leader>fm', '<cmd>Telescope marks<CR>')
map('n', '<leader>fe', '<cmd>Telescope file_browser<CR>')                      --nvimtree
map('n', '<leader>z', '<cmd>TZAtaraxis<CR>')                           --ataraxis
map('n', '<leader>x', '<cmd>TZAtaraxis l45 r45 t2 b2<CR>')
map('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')                      --nvimtree
map('t', '<leader>o', '<cmd>Vista<CR>')                   --fuzzN
map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
map('n', '<c-x>', '<cmd>BufferClose<CR>')
map('n', '<leader>b', '<cmd>BufferPick<CR>')
map('n', '<leader>bj', '<cmd>bprevious<CR>')
map('n', '<leader>bn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Git add .<CR>')
map('n', '<leader>gm', '<cmd>Git commit<CR>')
map('n', '<leader>gs', '<cmd>Git status<CR>')
map('n', '<leader>gl', '<cmd>Git pull<CR>')
map('n', '<leader>gu', '<cmd>Git push<CR>')
map('n', '<leader>q', '<cmd>TroubleToggle<CR>')
cmd([[autocmd BufWritePre * %s/\s\+$//e]])                             --remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])
cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
cmd([[autocmd FileChangedShellPost * call v:lua.vim.notify("File changed on disk. Buffer reloaded!", 'warn', {'title': 'File Notify', 'timeout': 2000})]])
cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
for _, num in pairs(numbers) do
  map('n', '<leader>'..num, '<cmd>BufferGoto '..num..'<CR>')
end

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- LeaderF
-- g.Lf_WindowPosition = 'popup'
-- g.Lf_PreviewInPopup = 1
-- g.Lf_ShortcutF = '<C-P>'
-- execute("call wilder#setup({'modes': [':', '/', '?']})")

--visual multi
nvim_exec([[
let g:VM_maps = {}
let g:VM_default_mappings = 0
let g:VM_maps["Add Cursor Down"] = '<A-j>'
let g:VM_maps["Add Cursor Up"] = '<A-k>'
let g:indent_blankline_char_highlight_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_filetype_exclude = ['help', 'dashboard', 'NvimTree', 'telescope']
]], false)

-- fastfold
--[[ g.fastfold_savehook = 1
g.fastfold_fold_command_suffixes =  {'x','X','a','A','o','O','c','C'}
g.fastfold_fold_movement_commands = {']z', '[z', 'zj', 'zk'}
g.markdown_folding = 1
g.tex_fold_enabled = 1
g.vimsyn_folding = 'af'
g.xml_syntax_folding = 1
g.javaScript_fold = 1
g.sh_fold_enabled= 7
g.ruby_fold = 1
g.perl_fold = 1
g.perl_fold_blocks = 1
g.r_syntax_folding = 1
g.rust_fold = 1
g.php_folding = 1 ]]

--barbar
nvim_exec([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.auto_hide = v:true
let bufferline.icons = 'both'
]], false)

g.vista_default_executive = 'nvim_lsp'

require("indent_blankline").setup {
    buftype_exclude = {"terminal", "telescope", "nvim-tree"},
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
-- auto-session
vim.o.sessionoptions="buffers,curdir"
require('auto-session').setup()

--theme
cmd 'colorscheme nightfly'
local notify = require("notify")

require'lightspeed'.setup {
  jump_to_first_match = true,
  jump_on_partial_input_safety_timeout = 400,
  -- This can get _really_ slow if the window has a lot of content,
  -- turn it on only if your machine can always cope with it.
  highlight_unique_chars = false,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 5,
  full_inclusive_prefix_key = '<c-x>',
  -- By default, the values of these will be decided at runtime,
  -- based on `jump_to_first_match`.
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil,
}

--nvim treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {"vue", "html", "javascript", "typescript", "css", "scss", "json", "jsonc", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  autotag = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
  incremental_selection = {
    enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    disable = { "cpp", "lua" },
    keymaps = {                       -- mappings for incremental selection (visual mappings)
      init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
      node_incremental = "grn",       -- increment to the upper named parent
      scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm",       -- decrement to the previous node
    }
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
        ["iF"] = {
          javascript = "(function_definition) @function",
          typescript = "(function_definition) @function",
          rust = "(function_definition) @function",
        },
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
  },
}

local lspkind = require('lspkind')
local cmp = require'cmp'

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine'},
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'treesitter' },
    { name = 'calc' },
    { name = 'emoji' },
    -- { name = 'spell' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
      vim_item.menu = ({
        path = "   [Path]",
        buffer = "   [Buffer]",
        nvim_lsp = "   [LSP]",
        vsnip = "   [Vsnip]",
        treesitter = "   [Ts]",
        calc = "   [Calc]",
        spell = "   [Spell]",
        emoji = " ﲃ  [Emoji]",
        cmp_tabnine = "⦿ [Tn]"
      })[entry.source.name]
      return vim_item
    end
  },
  experimental = {
    ghost_text = true
  }
})

-- Signature help
require('lsp_signature').on_attach()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
  }
)

-- just use lspkind
--[[ vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)"
} ]]

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', '[f', '<cmd>Lspsaga lsp_finder<CR>', opts)
  buf_set_keymap('n', '[a', '<cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('x', '[a', '<cmd>Lspsaga range_code_action<CR>', opts)
  buf_set_keymap('n', '[o', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '[s', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_set_keymap('n', '[n', '<cmd>Lspsaga rename<CR>', opts)
  buf_set_keymap('n', '[p', '<cmd>Lspsaga preview_definition<CR>', opts)
  buf_set_keymap('n', '[l', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>fo", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  local msg = string.format("Language server %s started!", client.name)
  notify(msg, 'info', {title = 'LSP Notify', timeout = 1000})
end

-- npm install --global vls @volar/server vscode-langservers-extracted typescript typescript-language-server graphql-language-service-cli dockerfile-language-server-nodejs stylelint-lsp yaml-language-server prettier
-- can use rls or rust_analyzer

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function setup_servers()
  -- local servers = { "cssls", "html", "rust_analyzer", "tsserver",  "graphql", "volar", "jsonls", "dockerls" }
  -- local nvim_lsp = require'lspconfig'
  local lsp_installer = require("nvim-lsp-installer")
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  lsp_installer.on_server_ready(function(server)
      server:setup(opts)
  end)
  -- for _, server in pairs(servers) do
  --   nvim_lsp[server].setup{
  --     on_attach = on_attach,
  --     capabilities = capabilities
  --   }
  -- end
end

setup_servers()

vim.lsp.set_log_level("debug")
require("trouble").setup {}
require("lspkind").init()
require'diffview'.setup{}
require('nvim-autopairs').setup()

--colorizer
require'colorizer'.setup()

--[[ require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>s',
  }
}) ]]

--nvim-tree
g.nvim_tree_side = "left"
g.nvim_tree_width = 25
-- g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_quit_on_open = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ":~"
g.nvim_tree_allow_resize = 1

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git  = {
      unstaged = "",
      staged = "✓",
      unmerged = "",
      renamed = "",
      untracked = "",
      deleted = "",
      ignored = ""
      },
    folder  = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
      symlink_open = "",
      },
      lsp  = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
}

-- for projects
g.nvim_tree_respect_buf_cwd = 1

require("nvim-tree").setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})

--gitsigns
require('gitsigns').setup {
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

    -- Text objects
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

fn.sign_define(
    "LspDiagnosticsSignError",
    {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
fn.sign_define(
    "LspDiagnosticsSignWarning",
    {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
fn.sign_define(
    "LspDiagnosticsSignHint",
    {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
fn.sign_define(
    "LspDiagnosticsSignInformation",
    {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)

g.dashboard_session_directory = '~/.sessions'
g.dashboard_default_executive = 'telescope'

if vim.fn.has 'win32' == 1 then
  cmd("let packages = len(globpath('~/AppData/Local/nvim-data/site/pack/packer/start', '*', 0, 1))")
else
  cmd("let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))")
end

nvim_exec([[
    let g:dashboard_custom_footer = ['LuaJIT loaded '..packages..' packages']
]], false)

g.dashboard_custom_section = {
    a = {description = {'  Reload Last Session            SPC q l'}, command = 'SessionLoad'},
    b = {description = {'  Recently Opened Files          SPC f r'}, command = 'Telescope oldfiles'},
    c = {description = {'  Open Project                   SPC f p'}, command = 'Telescope Project'},
    d = {description = {'  Jump to Bookmark               SPC f m'}, command = 'Telescope marks'},
    e = {description = {'  Find File                      SPC f  '}, command = 'Telescope find_files'},
    f = {description = {'  Find Word                      SPC g  '}, command = 'Telescope live_grep'},
    g = {description = {'  Open Neovim Configuration      SPC f e'}, command = ':e ~/AppData/Local/nvim/init.lua'},
}

local prettier = function ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
    stdin = true
  }
end
require('formatter').setup({
  filetype = {
    javascript = {
      prettier
    },
    typescript = {
      prettier
    },
  }
})

-- feline config
local get_diag = function(str)
  local count = vim.lsp.diagnostic.get_count(0, str)
  return (count > 0) and ' '..count..' ' or ''
end

local vi_mode_provider = function()
    local mode_alias = {
      n = 'NORMAL',
      no = 'NORMAL',
      i = 'INSERT',
      v = 'VISUAL',
      V = 'V-LINE',
      [''] = 'V-BLOCK',
      c = 'COMMAND',
      cv = 'COMMAND',
      ce = 'COMMAND',
      R = 'REPLACE',
      Rv = 'REPLACE',
      s = 'SELECT',
      S = 'SELECT',
      [''] = 'SELECT',
      t = 'TERMINAL',
    }
    return ' ' .. mode_alias[vim.fn.mode()] .. ' '
end

local percentage_provider = function()
  local cursor = require 'feline.providers.cursor'
  return ' ' .. cursor.line_percentage() .. ' '
end

local vi_mode_hl = function()
  local vi_mode = require 'feline.providers.vi_mode'
  return {
    name = vi_mode.get_mode_highlight_name(),
    fg = 'bg',
    bg = vi_mode.get_mode_color(),
    style = 'bold',
  }
end

require("nvim-gps").setup()

require'feline'.setup {
  colors = {
    black = '#434C5E',
    skyblue = '#81A1C1',
    cyan = '#88C0D0',
    green  = '#8FBCBB',
    oceanblue = '#5E81AC',
    magenta = '#B48EAD',
    orange = '#D08770',
    red = '#EC5F67',
    violet = '#B48EAD',
    white  = '#ECEFF4',
    yellow = '#EBCB8B',
    fg = '#8FBCBB',
    bg = '#2E3440',
  },
  vi_mode_colors = {
    NORMAL = 'cyan',
    OP = 'cyan',
    INSERT = 'white',
    VISUAL = 'green',
    BLOCK = 'green',
    REPLACE = 'yellow',
    ['V-REPLACE'] = 'yellow',
    ENTER = 'cyan',
    MORE = 'cyan',
    SELECT = 'magenta',
    COMMAND = 'cyan',
    SHELL = 'skyblue',
    TERM = 'skyblue',
    NONE = 'orange',
  },
  components = {
    active = {
      {
        { provider = vi_mode_provider, hl = vi_mode_hl, right_sep = ' ' },
        { provider = 'git_branch' , icon = ' ', right_sep = '  ',
          enabled = function() return vim.b.gitsigns_status_dict ~= nil end },
        { provider = 'file_info' },
        { provider = function() return require('nvim-gps').get_location() end, enabled = function() return require('nvim-gps') .is_available() end },
        { provider = '' , hl = { fg = 'bg', bg = 'black' }},
      },
      {},
      {
        { provider = function() return get_diag("Error") end,
          hl = { fg = 'bg', bg = 'red', style = 'bold' },
          left_sep = { str = '', hl = { fg = 'red', bg = 'black' }},
          right_sep = { str = '', hl = { fg = 'yellow', bg = 'red' }}},
        { provider = function() return get_diag("Warning") end,
          hl = { fg = 'bg', bg = 'yellow', style = 'bold'  },
          right_sep = { str = '', hl = { fg = 'cyan', bg = 'yellow' }}},
        { provider = function() return get_diag("Information") end,
          hl = { fg = 'bg', bg = 'cyan', style = 'bold' },
          right_sep = { str = '', hl = { fg = 'oceanblue', bg = 'cyan' }}},
        { provider = function() return get_diag("Hint") end,
          hl = { fg = 'bg', bg = 'oceanblue', style = 'bold' },
          right_sep = { str = '', hl = { fg = 'bg', bg = 'oceanblue', }}},
        { provider = 'file_encoding', left_sep = ' ' },
        { provider = 'position', left_sep = ' ', right_sep = ' ' },
        { provider = percentage_provider,
          hl = { fg = 'bg', bg = 'skyblue', style = 'bold' }},
      }
    },
    inactive = {
      {
        { provider = vi_mode_provider, hl = vi_mode_hl, right_sep = ' ' },
        { provider = 'git_branch' , icon = ' ', right_sep = '  ',
          enabled = function() return vim.b.gitsigns_status_dict ~= nil end },
        { provider = 'file_info' },
        { provider = '' , hl = { fg = 'bg', bg = 'black' }},
      },
      {},
      {}
    },
  },
  force_inactive = {
    filetypes = {
      'NvimTree',
      'packer',
      'LspTrouble',
    },
    buftypes = {'terminal'},
    bufnames = {},
  }
}

require("which-key").setup {}


require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  diagnostics     = {
    enable = true
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },

  view = {
    width = 30,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}
