local utils = require("telescope.utils")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local previewers = require("telescope.previewers")
local entry_display = require("telescope.pickers.entry_display")

-- 避免大文件
local previewer_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require("telescope").setup({
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = " ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
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
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" },     -- default = nil,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = previewer_maker,
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      advanced_git_search = {
        -- fugitive or diffview
        diff_plugin = "fugitive",
        -- customize git in previewer
        -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
        git_flags = {},
        -- customize git diff in previewer
        -- e.g. flags such as { "--raw" }
        git_diff_flags = {},
      },
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<M-p>"] = action_layout.toggle_preview,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<esc>"] = actions.close,
        ["<C-[>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key,         -- keys from pressing <C-/>
      },

      n = {
        ["<M-p>"] = action_layout.toggle_preview,

        ["<esc>"] = actions.close,
        ["<C-[>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("notify")
-- require('telescope').load_extension('bookmarks')

-- https://luyuhuang.tech/2023/03/21/nvim.html
local function live_grep_opts(opts)
  local flags = tostring(vim.v.count)
  local additional_args = {}
  local prompt_title = "Live Grep"
  if flags:find("1") then
    prompt_title = prompt_title .. " [.*]"
  else
    table.insert(additional_args, "--fixed-strings")
  end
  if flags:find("2") then
    prompt_title = prompt_title .. " [w]"
    table.insert(additional_args, "--word-regexp")
  end
  if flags:find("3") then
    prompt_title = prompt_title .. " [Aa]"
    table.insert(additional_args, "--case-sensitive")
  end

  opts = opts or {}
  opts.additional_args = function()
    return additional_args
  end
  opts.prompt_title = prompt_title
  return opts
end

vim.keymap.set("n", "<leader>/", function()
  builtin.live_grep(live_grep_opts({}))
end, { desc = "Live Grep" })

vim.api.nvim_create_user_command(
  "DiffCommitLine",
  "lua require('telescope').extensions.advanced_git_search.diff_commit_line()",
  { range = true }
)

vim.keymap.set("n", "<leader>gj", function()
  builtin.jumplist({ show_line = false })
end, { desc = "Jump List" })

vim.keymap.set("n", "<leader>gb", function()
  local opts = { current_file = vim.fn.expand("%") }
  builtin.git_bcommits({
    git_command = {
      "git",
      "log",
      -- "--pretty=oneline",
      -- "--abbrev-commit",
      "--date=format:%y/%m/%d",
      "--pretty=format:%C(auto) %h %ad %s",
      "--follow",
    },
    previewer = {
      previewers.git_commit_diff_to_parent.new(opts),
      previewers.git_commit_message.new(opts),
      previewers.git_commit_diff_as_was.new(opts),
      previewers.git_commit_diff_to_head.new(opts),
    },
  })
end, { desc = "Git commit diff" })

vim.keymap.set("n", "<leader>ld", function()
  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 4 },
      { width = nil },
      { width = nil },
      { width = nil },
    },
  }, { desc = "" })
  local function make_entry(entry)
    return {
      value = entry.filename,
      display = function(item)
        local colors = {
          ["ERROR"] = "Red",
          ["WARN"] = "Purple",
          ["INFO"] = "Yellow",
          ["HINT"] = "Blue",
        }
        return displayer({
          { string.format("%4d", item.lnum),         "Aqua" },
          { utils.transform_path({}, item.filename), "" },
          {
            string.format("%s> %s", string.lower(string.sub(item.type, 1, 1)), item.text),
            colors[entry.type],
          },
        })
      end,
      filename = entry.filename,
      ordinal = utils.transform_path({}, entry.filename) .. entry.type,
      lnum = entry.lnum,
      col = entry.col,
      type = entry.type,
      text = entry.text,
    }
  end
  builtin.diagnostics({
    entry_maker = make_entry,
  })
end, { desc = "Git file status" })
