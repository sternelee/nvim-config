--make life easier
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
-- https://jdhao.github.io/2021/07/11/from_vim_plug_to_packer
--setup packer
cmd [[packadd packer.nvim]]
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nathom/filetype.nvim'
  -- 状态栏
  use {'famiu/feline.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-tree.lua'
  -- use 'glepnir/dashboard-nvim'
  use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'SmiteshP/nvim-gps'
  -- git相关
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  -- use 'lambdalisue/gina.vim'
  use 'f-person/git-blame.nvim' -- 显示git message
  use 'jreybert/vimagit'
  -- use 'samoshkin/vim-mergetool'
  -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  -- 语法高亮
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  -- use 'mfussenegger/nvim-ts-hint-textobject'
  use {
    'romgrk/nvim-treesitter-context',
    config = function()
      require("treesitter-context").setup {}
    end
  }
  use 'nvim-treesitter/playground'
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
    }
    end
  }
  use 'norcalli/nvim-colorizer.lua' -- 色值高亮
  use 'ellisonleao/glow.nvim'
  use 'bluz71/vim-nightfly-guicolors'
  use 'lukas-reineke/indent-blankline.nvim'
  -- 导航finder操作
  use 'mg979/vim-visual-multi'
  use 'kevinhwang91/nvim-hlslens'
  use 'phaazon/hop.nvim'
  -- use 'easymotion/vim-easymotion'
  use 'ggandor/lightspeed.nvim'
  -- use 'nvim-telescope/telescope.nvim'
  use { 'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' } -- optional for icons
  }
  -- 语法建议
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  --[[ use {'ms-jpq/coq_nvim', branch =  'coq' }
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {'ms-jpq/coq.thirdparty', branch = '3p'} ]]
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use {'hrsh7th/cmp-nvim-lsp', requires = {
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-vsnip'},
    {'ray-x/cmp-treesitter'},
    {'hrsh7th/cmp-calc'},
    {'hrsh7th/cmp-emoji'},
    {'hrsh7th/cmp-cmdline'},
    -- {'tzachar/cmp-tabnine', run='./install.sh'}
  }}
  -- 语法提示
  use 'folke/lsp-trouble.nvim'
  -- use {'kevinhwang91/nvim-bqf'}
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
  -- use { 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = { 'jose-elias-alvarez/null-ls.nvim' }}
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
        require('kommentary.config').configure_language("vue", {
            single_line_comment_string = "//",
            multi_line_comment_strings = {"/*", "*/"},
        })
      end
  }
  -- use 'windwp/nvim-autopairs' -- 自动符号匹配, 但vue兼容有问题
  use 'jiangmiao/auto-pairs'
  -- use 'steelsojka/pears.nvim'
  use 'windwp/nvim-ts-autotag'
  use 'vigoux/architext.nvim'
  use {
    'blackCauldron7/surround.nvim',
    config = function()
      require "surround".setup {}
    end
  }
  --[[ use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
      }
    end
  } ]]
  use 'folke/which-key.nvim' -- 提示leader按键
  use 'sindrets/diffview.nvim' -- diff对比
  use 'p00f/nvim-ts-rainbow' -- 彩虹匹配
  use 'folke/todo-comments.nvim'
  -- 方便写注释
  use {
      "danymat/neogen",
      config = function()
          require('neogen').setup {
              enabled = true
          }
      end,
      requires = "nvim-treesitter/nvim-treesitter"
  }
  use 'ntpeters/vim-better-whitespace'
  use 'ThePrimeagen/vim-be-good'
  use 'mhartington/formatter.nvim'
  use 'rcarriga/nvim-notify'
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}
  -- use 'wfxr/minimap.vim'
  -- use 'lewis6991/impatient.nvim'
  use 'numToStr/FTerm.nvim'
  use {
    'VonHeikemen/fine-cmdline.nvim',
    requires = {
      {'MunifTanjim/nui.nvim'}
    }
  }
  use {
    'VonHeikemen/searchbox.nvim',
    requires = {
      {'MunifTanjim/nui.nvim'}
    }
  }
  use 'mfussenegger/nvim-dap'

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
opt('o', 'wrap', true)
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
opt('o', 'scrolljump', 6)
opt('o', 'undofile', true)

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
--[[ map('n', '<leader>tp', '<cmd>Telescope<CR>')                   --fuzzy
map('n', '<leader>tr', '<cmd>Telescope oldfiles<CR>')                   --fuzzy
map('n', '<leader>tf', '<cmd>Telescope find_files<CR>')
map('n', '<leader>tb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>tw', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>ts', '<cmd>Telescope treesitter<CR>')
map('n', '<leader>tc', '<cmd>Telescope commands<CR>')
map('n', '<leader>tm', '<cmd>Telescope marks<CR>')
map('n', '<leader>te', '<cmd>Telescope file_browser<CR>')                      --nvimtree ]]
map('n', '<leader>f', '<cmd>FzfLua files<CR>')
map('n', '<leader>g', '<cmd>FzfLua live_grep<CR>')
map('n', '<leader>fw', '<cmd>FzfLua grep_cword<CR>')
map('n', '<leader>b', '<cmd>FzfLua buffers<CR>')
map('n', '<leader>fm', '<cmd>FzfLua marks<CR>')
map('n', '<leader>uf', '<cmd>FzfLua files_resume<CR>')
map('n', '<leader>ug', '<cmd>FzfLua live_grep_resume<CR>')
map('n', '<A-i>', '<cmd>lua require("FTerm").toggle()<CR>')
map('t', '<A-i>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>')
map('n', '<C-p>', '<cmd>lua require("fine-cmdline").open()<CR>')
map('n', '<leader>p', '<cmd>lua require("fine-cmdline").open()<CR>')
map('n', '<leader>fs', '<cmd>lua require("searchbox").incsearch()<CR>')
map('n', '<leader>fh', '<cmd>lua require("searchbox").replace()<CR>')
--[[ map('n', '<leader>z', '<cmd>TZAtaraxis<CR>')                           --ataraxis
map('n', '<leader>x', '<cmd>TZAtaraxis l45 r45 t2 b2<CR>') ]]
map('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')                      --nvimtree
map('n', '<leader>sl', '<cmd>SessionLoad<CR>')
map('n', '<leader>ss', '<cmd>SessionSave<CR>')
map('t', '<leader>o', '<cmd>Vista<CR>')                   --fuzzN
map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
map('n', '<c-x>', '<cmd>BufferClose<CR>')
-- map('n', '<leader>b', '<cmd>BufferPick<CR>')
map('n', '<leader>bj', '<cmd>bprevious<CR>')
map('n', '<leader>bn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Git add .<CR>')
map('n', '<leader>gm', '<cmd>Git commit<CR>')
map('n', '<leader>gs', '<cmd>Git status<CR>')
map('n', '<leader>gl', '<cmd>Git pull<CR>')
map('n', '<leader>gu', '<cmd>Git push<CR>')
map('n', '<leader>q', '<cmd>TroubleToggle<CR>')
cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]
cmd [[autocmd CursorHold,CursorHoldI * :lua require'nvim-lightbulb'.update_lightbulb()]]
cmd [[autocmd FileChangedShellPost * :lua require'notify'("File changed on disk. Buffer reloaded!", 'warn', {'title': 'File Notify', 'timeout': 1000})]]
cmd [[autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints()]]
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

nvim_exec([[
let g:VM_maps = {}
let g:VM_default_mappings = 0
let g:VM_maps["Add Cursor Down"] = '<A-j>'
let g:VM_maps["Add Cursor Up"] = '<A-k>'
let g:indent_blankline_char_highlight_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_filetype_exclude = ['help', 'dashboard', 'NvimTree', 'telescope', 'packer', 'alpha']
]], false)

--barbar
nvim_exec([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.auto_hide = v:true
let bufferline.icons = 'both'
]], false)

g.vista_default_executive = 'nvim_lsp'


-- vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winpos,terminal"

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

--theme
cmd 'colorscheme nightfly'

local notify = require("notify")

require'hop'.setup()

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

--[[ require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close
      }
    }
  }
} ]]

--nvim treesitter 编辑大文件卡顿时最好关闭
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
    enable = true,
    disable = { "cpp", "lua" },
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
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
--[[ local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })) ]]

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
    -- { name = 'cmp_tabnine'},
    { name = 'vsnip' },
    { name = 'buffer' },
    -- { name = 'treesitter' },
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
        cmp_tabnine = "⦿ [Tn]",
      })[entry.source.name]
      return vim_item
    end
  },
  experimental = {
    ghost_text = true
  }
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
  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      hi link LspReferenceRead Visual
      hi link LspReferenceText Visual
      hi link LspReferenceWrite Visual
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
  -- use null-ls for format
  -- client.resolved_capabilities.document_formatting = false
  -- client.resolved_capabilities.document_range_formatting = false

  local msg = string.format("Language server %s started!", client.name)
  notify(msg, 'info', {title = 'LSP Notify', timeout = 300})
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

-- require('null-ls').config({
--   sources = {
--     require('null-ls').builtins.formatting.prettier,
--     require('null-ls').builtins.formatting.eslint
--   },
--   debug = true,
-- })
-- require('lspconfig')["null-ls"].setup{}

require('fzf-lua').setup({
  lsp = {
    async_or_timeout = 3000,
  }
})
-- npm install --global vls @volar/server vscode-langservers-extracted typescript typescript-language-server graphql-language-service-cli dockerfile-language-server-nodejs stylelint-lsp yaml-language-server prettier
-- can use rls or rust_analyzer

-- coq
--[[ vim.g.coq_settings = {
  auto_start = true,
  clients = {
    tabnine = {
      enabled = true
    }
  }
}

local function setup_servers()
  local coq = require "coq"
  local lsp_installer = require("nvim-lsp-installer")
  local config = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  lsp_installer.on_server_ready(function(server)
      server:setup(
        coq.lsp_ensure_capabilities(config)
      )
  end)
end ]]

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

-- vim.lsp.set_log_level("debug")
require("trouble").setup {}
require("lspkind").init()
require'diffview'.setup{}
--[[ require('nvim-autopairs').setup{
  disable_filetype = { "TelescopePrompt" },
} ]]

--colorizer
require'colorizer'.setup{
  '*',
  css = { rgb_fn = true; }
}

--nvim-tree
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore              = {".git", "node_modules", ".cache"},
  hide_dotfiles       = 1,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  auto_close          = true,
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = { ".git", "node_modules", ".cache" },
  },
  system_open = {
    cmd  = nil,
    args = {}
  },

  view = {
    width = 30,
    side = 'right',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

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

-- g.dashboard_disable_statusline = 1
-- g.dashboard_session_directory = '~/.sessions'
-- -- g.dashboard_default_executive = 'telescope'
--
-- if vim.fn.has 'win32' == 1 then
--   cmd("let packages = len(globpath('~/AppData/Local/nvim-data/site/pack/packer/start', '*', 0, 1))")
-- else
--   cmd("let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))")
-- end
--
-- nvim_exec([[
--     let g:dashboard_custom_footer = ['LuaJIT loaded '..packages..' packages']
-- ]], false)
--
-- g.dashboard_custom_section = {
--     a = {description = {"  Find File                 SPC f  "}, command = "FzfLua files"},
--     b = {description = {"  Buffers                   SPC b  "}, command = "FzfLua buffers"},
--     c = {description = {"  Find Word                 SPC g  "}, command = "FzfLua live_grep"},
--     d = {description = {"  Bookmarks                 SPC f m"}, command = "FzfLua marks"},
--     e = {description = {"洛 New File                  SPC f n"}, command = "DashboardNewFile"},
-- }

require'alpha'.setup(require'alpha.themes.startify'.opts)

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
    vue = {
      prettier
    },
    json = {
      prettier
    }
  }
})

-- feline config

require("nvim-gps").setup()

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

local file_info_component = {
  provider = {
    name = 'file_info',
    opts = {
      type = 'short-path'
    }
  }
}

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
        file_info_component,
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
        file_info_component,
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

require('todo-comments').setup{
  signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
      --pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
      pattern = [[(KEYWORDS)]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
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
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
}

_G.whitespace_disabled_file_types = {
    'lsp-installer',
    'lspinfo',
    'TelescopePrompt',
    'dashboard'
}
function _G.whitespace_visibility(file_types)
    local better_whitespace_status = 1
    local current_file_type = vim.api.nvim_eval('&ft')
    for k,v in ipairs(file_types) do
        if current_file_type == "" or current_file_type == v then
            better_whitespace_status = 0
        end
    end

    -- vim.cmd('DisableWhitespace')
    if better_whitespace_status == 0 then
        vim.cmd('execute "DisableWhitespace"')
    else
        vim.cmd('execute "EnableWhitespace"')
    end
end

vim.cmd('autocmd BufEnter * lua whitespace_visibility(whitespace_disabled_file_types)')
--[[ BUG: I don't know why but it seems we must again specifcly run function for FileType dashboard.
we must have it in both whitespace_disabled_file_types and here.]]
vim.cmd('autocmd FileType dashboard execute "DisableWhitespace" | autocmd BufLeave <buffer> lua whitespace_visibility(whitespace_disabled_file_types)')

require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

require'fine-cmdline'.setup()
--[[ local neogit = require('neogit')
neogit.setup {} ]]
