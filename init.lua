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
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local ucmd = vim.api.nvim_create_user_command

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

nvim_exec([[set guifont=VictorMono\ NF:h14]], false)

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
cmd [[packadd packer.nvim]]
local packer = require('packer')
-- packer.init({
--   git = {
--     default_url_format = "https://gitcode.net/mirrors/%s"
--   }
-- })
packer.startup({function()
  use 'wbthomason/packer.nvim'
  use {'lewis6991/impatient.nvim'}
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nathom/filetype.nvim'
  use {'antoinemadec/FixCursorHold.nvim'}
  -- 状态栏
  use 'romgrk/barbar.nvim'
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
  use 'goolord/alpha-nvim'
  use 'SmiteshP/nvim-gps'
  -- git相关
  use 'tpope/vim-fugitive'
  use {'akinsho/git-conflict.nvim', opt = true, cmd = {'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth', 'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict'}, config = function()
    require('git-conflict').setup()
  end}
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
  -- use 'nvim-treesitter/nvim-tree-docs'
  use {
    'romgrk/nvim-treesitter-context',
    opt = true,
    event = 'BufRead',
    config = function()
      require('treesitter-context').setup {}
    end} -- or nvim_context_vt
  -- use {'haringsrob/nvim_context_vt', event = 'BufRead', config = function() require('nvim_context_vt'):setup() end}
  use {'nvim-treesitter/playground', opt = true, cmd = {'TSPlaygroundToggle'}}
  -- use "ziontee113/syntax-tree-surfer"
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
  use 'sainnhe/gruvbox-material'
  -- 显示导航线
  use {'lukas-reineke/indent-blankline.nvim', event = 'BufRead',
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        use_treesitter = true,
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
  use {'fedepujol/move.nvim', opt = true, event = 'BufRead'}
  use {'kevinhwang91/nvim-hlslens', opt = true, event = 'BufRead'} -- 显示高亮的按键位置
  use {'phaazon/hop.nvim', opt = true, cmd = {'HopWord', 'HopLine', 'HopPattern'}, config = function() require('hop'):setup() end}
  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require'project_nvim'.setup{}
    end
  }
  -- 语法建议
  use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
  use {'github/copilot.vim', opt = true, event = 'BufRead'}
  -- 语法提示
  use {
    'weilbith/nvim-code-action-menu',
    opt = true,
    cmd = 'CodeActionMenu',
  }
  use {'liuchengxu/vista.vim', opt = true, cmd = {'Vista'}}
  use {
    'NTBBloodbath/rest.nvim',
    ft = 'http',
    requires = {"nvim-lua/plenary.nvim" },
    config = function()
      require'rest-nvim'.setup() end}
  use {'pechorin/any-jump.vim', opt = true, cmd = {'AnyJump'}}
  use {'editorconfig/editorconfig-vim', opt = true, event = 'BufRead'}
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
  use {'AndrewRadev/switch.vim', opt = true, event = 'BufRead', cmd = {'Switch'}}
  use {'AndrewRadev/splitjoin.vim', opt = true, event = 'BufRead'}
  use {'tpope/vim-speeddating', opt = true, event = 'BufRead'}
  use {'nacro90/numb.nvim', opt = true, event = 'BufRead', config = function()
    require('numb').setup()
  end}
  use {'tpope/vim-eunuch', opt = true, cmd = {'Delete', 'Mkdir', 'Rename'}}
  use {'gennaro-tedesco/nvim-peekup', event = 'InsertEnter'} -- 查看历史的复制和删除的寄存器,快捷键 ""
  use {'tomtom/tcomment_vim'}
  use {'machakann/vim-sandwich', event = 'InsertEnter'}
  use {'toppair/reach.nvim', event = 'BufRead',
    config = function ()
      require('reach').setup({
        notifications = true
      })
    end}
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
  -- use {'hoschi/yode-nvim', event = 'BufRead', config = function () require('yode-nvim').setup({}) end}
  use 'folke/todo-comments.nvim'
  use 'ntpeters/vim-better-whitespace'
  use {'ThePrimeagen/vim-be-good', opt = true, cmd = 'VimBeGood'}
  use 'rcarriga/nvim-notify'
  use {'metakirby5/codi.vim', opt = true, cmd = {'Codi'}}
  use {'turbio/bracey.vim', opt = true, cmd = 'Bracey'}
  -- use { 'chipsenkbeil/distant.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     require('distant').setup {
  --       ['*'] = require('distant.settings').chip_default()
  --     }
  --   end }
  -- use {'brooth/far.vim', event = 'InsertEnter'} -- or nvim-pack/nvim-spectre 全局替换
  use {'nvim-pack/nvim-spectre',
    opt = true,
    event = 'InsertEnter',
    config = function()
      require('spectre').setup()
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
  use {
      "nvim-neorg/neorg",
      -- tag = "latest",
      ft = "norg",
      after = "nvim-treesitter",
      config = function()
          require('neorg').setup {
            load = {
              ["core.defaults"] = {},
            }
          }
      end
  }
  -- use {
  -- 	'xeluxee/competitest.nvim',
  -- 	requires = 'MunifTanjim/nui.nvim',
  -- 	config = function() require'competitest'.setup() end
  -- } -- 竞技编程

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
opt('o', 'writebackup', false)
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
  if opts then options = vim.tbl_extend('force', options) end
  remap(mode, lhs, rhs, options)
end

g.do_filetype_lua = 1 -- nvim > 0.7
g.did_load_filetypes = 0
g.mapleader = " "                                                     --leader
g.maplocalleader = ","
map('n', 'p', '"0p')
map('v', 'p', '"0p')
-- map('i', 'jk', '<esc>')                                               --jk to exit
-- map('c', 'jk', '<C-C>') -- 这里有可能会dump
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
map('n', '<leader>f', '<cmd>CocList files<CR>')
map('n', '<leader>b', '<cmd>CocList buffers<CR>')
map('n', '<leader>m', '<cmd>CocList marks<CR>')
map('n', '<leader>/', '<cmd>CocList grep<CR>')
map('n', '<leader>\'', '<cmd>CocListResume<CR>')
map('n', '<leader>s', '<cmd>CocList grep<CR>')
map('n', '<leader>p', '<cmd>CocList commands<CR>')
map('n', 'fc', '<cmd>CocList commands<CR>')
map('n', 'fp', '<cmd>CocList projects<CR>')
map('n', '<leader>tb', '<cmd>SidebarNvimToggle<CR>')
map('n', '<leader>tl', '<cmd>Twilight<CR>')
map('n', '<leader>sl', '<cmd>SessionLoad<CR>')
map('n', '<leader>ss', '<cmd>SessionSave<CR>')
map('n', '<leader>S', '<cmd>Vista<CR>')
map('n', '<leader>cs', '<cmd>CocStart<CR>')
map('n', '<leader>td', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>tD', '<cmd>DiffviewClose<CR>')
map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
map('n', '<s-q>', '<cmd>BufferClose<CR>')
map('n', 'gn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Git add %:p<CR>')
map('n', '<leader>go', '<cmd>Git add .<CR>')
map('n', '<leader>gm', '<cmd>Git commit<CR>')
map('n', '<leader>gs', '<cmd>Git status<CR>')
map('n', '<leader>gu', '<cmd>Git pull<CR>')
map('n', '<leader>gh', '<cmd>Git push<CR>')
map('n', '<leader>gl', '<cmd>Git log<CR>')
map('n', '<leader><leader>i', '<cmd>PackerInstall<CR>')
map('n', '<leader><leader>u', '<cmd>PackerUpdate<CR>')

map('n', '<leader>j', '<cmd>AnyJump<CR>')
map('v', '<leader>j', '<cmd>AnyJumpVisual<CR>')
map('n', '<leader>ab', '<cmd>AnyJumpBack<CR>')
map('n', '<leader>al', '<cmd>AnyJumpLastResults<CR>')

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

-- move.nvim
map('n', '<M-j>', '<cmd>MoveLine(1)<CR>')
map('n', '<M-j>', '<cmd>MoveLine(1)<CR>')
map('n', '<M-k>', '<cmd>MoveLine(-1)<CR>')
map('v', '<M-j>', '<cmd>MoveBlock(1)<CR>')
map('v', '<M-j>', '<cmd>MoveBlock(-1)<CR>')
map('n', '<M-l>', '<cmd>MoveHChar(1)<CR>')
map('n', '<M-h>', '<cmd>MoveHChar(-1)<CR>')
map('v', '<M-l>', '<cmd>MoveHBlock(1)<CR>')
map('n', '<M-h>', '<cmd>MoveHBlock(1)<CR>')

-- LSP
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
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
-- map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

map('n', '<leader>l', '<cmd>Lspsaga lsp_finder<CR>')
map('n', 'ga', '<cmd>Lspsaga code_action<CR>')
map('x', 'gA', '<cmd>Lspsaga range_code_action<CR>')
map('n', 'gam', '<cmd>CodeActionMenu<CR>')
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
map('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>')
map('n', 'gr', '<cmd>Lspsaga rename<CR>')
map('n', 'gi', '<cmd>Lspsaga implement<CR>')
map('n', 'gE', '<cmd>Lspsaga preview_definition<CR>')
map('n', 'gC', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
map('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')
map('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')

-- cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
-- cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]

autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
    end,
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
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

g.vista_default_executive = 'coc'
g.markdown_fenced_language = {
  "ts=typescript"
}

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

--theme
g.moonflyIgnoreDefaultColors = 1
g.nightflyCursorColor = 1
g.nightflyNormalFloat = 1

-- gruvbox-material
g.gruvbox_material_background = 'hard'
g.gruvbox_material_better_performance = 1
cmd 'colorscheme nightfly'

-- editorconfig-vim
g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*', ''}

local notify = require("notify")
vim.notify = notify

local noTsAndLSP = function (lang, bufnr)
  local n = vim.api.nvim_buf_line_count(bufnr)
  return  n > 10000 or n < 6 -- 大于一万行，或小于6行（可能是压缩的js文件）
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

require'statusline'
-- vim.o.winbar = "%{%v:lua.require'winbar'.eval()%}"

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
   'coc-explorer'
}
g.coc_start_at_startup=0
g.coc_default_semantic_highlight_groups = 1
g.coc_enable_locationlist = 0
g.coc_selectmode_mapping = 0

cmd [[ source ~/AppData/Local/nvim/config.vim ]]

remap("n", "<leader>.", "<Plug>(coc-codeaction)", {})
-- remap("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})
remap("n", "]d", "<Plug>(coc-diagnostic-prev)", {silent = true})
remap("n", "[d", "<Plug>(coc-diagnostic-next)", {silent = true})
remap("n", "gd", "<Plug>(coc-definition)", {silent = true})
remap("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
remap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
remap("n", "gr", "<Plug>(coc-references)", {silent = true})
remap("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
remap("n", "<leader>rn", "<Plug>(coc-rename)", {})
remap("n", "fo", ":CocCommand prettier.formatFile<CR>", {noremap = true})
remap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
remap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
remap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
remap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

