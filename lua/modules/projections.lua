require("projections").setup({
  workspaces = { "~/dev" },
  patterns = { ".git", ".svn", ".hg" },
  store_hooks = { pre = nil, post = nil },
  restore_hooks = { pre = nil, post = nil },
})

-- Bind <leader>p to Telescope find_projects
-- on select, switch to project's root and attempt to load project's session
local Workspace = require("projections.workspace")
local Session = require("projections.session")

require('telescope').load_extension('projections')

vim.keymap.set("n", "fp", function()
    local find_projects = require("telescope").extensions.projections.projections
    find_projects({
        action = function(selection)
            -- chdir is required since there might not be a session file
            vim.fn.chdir(selection.value)
            Session.restore(selection.value)
        end,
    })
end, { desc = "Find projects" })

-- Autostore session on DirChange and VimExit
vim.api.nvim_create_autocmd({ 'DirChangedPre', 'VimLeavePre' }, {
    callback = function() Session.store(vim.loop.cwd()) end,
    desc = "Store project session",
})

vim.api.nvim_create_user_command("StoreProjectSession", function()
    Session.store(vim.loop.cwd())
end, {})

vim.api.nvim_create_user_command("RestoreProjectSession", function()
    Session.restore(vim.loop.cwd())
end, {})

-- Add workspace command
vim.api.nvim_create_user_command("AddWorkspace", function()
    Workspace.add(vim.loop.cwd())
end, {})
