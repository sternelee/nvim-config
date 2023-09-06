local M = {}
M.on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    globals = { "vim", "use", "bit", "require" },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            },
        })

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
end
return M
