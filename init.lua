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
  use 'goolord/alpha-nvim'
  use 'SmiteshP/nvim-gps'
  use 'sidebar-nvim/sidebar.nvim'
  -- git相关
  use 'tpope/vim-fugitive'
  use {'lambdalisue/gina.vim'}
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
  use {'ellisonleao/glow.nvim', event = 'BufRead'} -- markdown 文件预览
  -- theme 主题 -- https://vimcolorschemes.com/
  use 'bluz71/vim-nightfly-guicolors'
  use 'ellisonleao/gruvbox.nvim'
  use 'Mofiqul/vscode.nvim'
  use {'catppuccin/nvim', as = 'catppuccin'}
  -- use 'vv9k/bogster'
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
  use 'mg979/vim-visual-multi'
  use {'kevinhwang91/nvim-hlslens', event = 'BufRead'} -- 显示高亮的按键位置
  use {'m-demare/hlargs.nvim', event = 'BufRead',
    config = function ()
      require('hlargs').setup{}
    end}
  use {'phaazon/hop.nvim', event = 'BufRead', config = function() require('hop'):setup() end}
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  -- 语法建议
  use 'neoclide/coc.nvim'
  use {'ThePrimeagen/refactoring.nvim', config = function () require('refactoring').setup() end}
  use {'kevinhwang91/nvim-bqf', ft = 'qf', event = 'BufRead', config = function() require('bqf'):setup() end}
  use {'liuchengxu/vista.vim',opt = true, cmd = {'Vista'}}
  -- 方便操作
  use 'tpope/vim-eunuch'
  use {'gennaro-tedesco/nvim-peekup', event = 'InsertEnter'} -- 查看历史的复制和删除的寄存器,快捷键 ""
  use 'voldikss/vim-translator' -- npm install fanyi -g 安装翻译
  use {'numToStr/Comment.nvim', requires = {'JoosepAlviste/nvim-ts-context-commentstring'}}
  use {'windwp/nvim-ts-autotag', event = 'InsertEnter'}
  use {'machakann/vim-sandwich', event = 'InsertEnter'}
  use {'jdhao/better-escape.vim', event = 'InsertEnter'}
  use {'toppair/reach.nvim', event = 'BufRead',
    config = function ()
      require('reach').setup({
        notifications = true
      })
    end}
  use 'folke/which-key.nvim' -- 提示leader按键
  use 'p00f/nvim-ts-rainbow' -- 彩虹匹配
  use {'pechorin/any-jump.vim', event = 'InsertEnter'}
  use {'hoschi/yode-nvim', event = 'BufRead', config = function () require('yode-nvim').setup({}) end}
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
    requires = { 'mfussenegger/nvim-dap', 'Pocco81/DAPInstall.nvim', 'sidebar-nvim/sections-dap'},
    config = function()
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
  use {'Saecki/crates.nvim',
     event = { "BufRead Cargo.toml" },
    config = function()
        require('crates').setup()
    end}
  -- use { 'chipsenkbeil/distant.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     require('distant').setup {
  --       ['*'] = require('distant.settings').chip_default()
  --     }
  --   end }

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
map('n', '<leader>tl', '<cmd>Twilight<CR>')
map('n', '<leader>tw', '<cmd>Translate<CR>')
map('n', '<leader>th', '<cmd>lua require("hlargs").toggle()<CR>')
map('n', '<leader>sl', '<cmd>SessionLoad<CR>')
map('n', '<leader>ss', '<cmd>SessionSave<CR>')
map('n', '<leader>S', '<cmd>Vista<CR>')                   --fuzzN
map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
map('n', '<c-x>', '<cmd>BufferClose<CR>')
map('n', 'gb', '<cmd>BufferPick<CR>')
map('n', 'gp', '<cmd>bprevious<CR>')
map('n', 'gn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Gina add .<CR>')
map('n', '<leader>gm', '<cmd>Gina commit<CR>')
map('n', '<leader>gs', '<cmd>Gina status<CR>')
map('n', '<leader>gl', '<cmd>Gina pull<CR>')
map('n', '<leader>gu', '<cmd>Gina push<CR>')
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
map('n', '<leader>td', '<cmd>lua require("dapui").toggle()<CR>')

cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]

cmd[[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  augroup END
]]

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

g.vista_default_executive = 'coc'
g.markdown_fenced_language = {
  "ts=typescript"
}

vim.opt.list = true
vim.opt.listchars:append("space:⋅")


--theme
g.vscode_style = "dark"
g.vscode_italic_comment = 1

require'catppuccin'.setup{}

cmd 'colorscheme nightfly'

local notify = require("notify")
vim.notify = notify

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

--nvim treesitter 编辑大文件卡顿时最好关闭 highlight, rainbow, autotag
require('nvim-treesitter.configs').setup {
  ensure_installed = {"vue", "html", "javascript", "typescript", "scss", "json", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash", "http"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  disable_tokenziation_after_line = 10000,
  additional_vim_regex_highlighting = false,
  highlight = {
    enable = true,
    -- disable = function (lang, bufnr)
    --   return lang == "javascript" and vim.api.nvim_buf_line_count(bufnr) > 10000
    -- end
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  autotag = {
    enable = true,
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
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
   'coc-spell-checker',
   'coc-pairs',
   'coc-explorer'
}
g.coc_start_at_startup=0
g.coc_default_semantic_highlight_groups = 1
g.coc_enable_locationlist = 0
g.coc_selectmode_mapping = 0
cmd [[
  hi! link CocSemDefaultLibrary Special
  hi! link CocSemDocumentation Number
  hi! CocSemStatic gui=bold
]]
cmd [[ source ~/.config/nvim/config.vim ]]
