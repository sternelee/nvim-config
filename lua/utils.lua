-- from https://github.com/lvim-tech/lvim/blob/production/lua/core/funcs.lua
local M = {}

M.merge = function(tbl1, tbl2)
    if type(tbl1) == "table" and type(tbl2) == "table" then
        for k, v in pairs(tbl2) do
            if type(v) == "table" and type(tbl1[k] or false) == "table" then
                M.merge(tbl1[k], v)
            else
                tbl1[k] = v
            end
        end
    end
    return tbl1
end

M.sort = function(tbl)
    local arr = {}
    for key, value in pairs(tbl) do
        arr[#arr + 1] = { key, value }
    end
    for ix, value in ipairs(arr) do
        tbl[ix] = value
    end
    return tbl
end

M.keymaps = function(mode, opts, keymaps)
    for _, keymap in ipairs(keymaps) do
        vim.keymap.set(mode, keymap[1], keymap[2], opts)
    end
end

M.remove_duplicate = function(tbl)
    local hash = {}
    local res = {}
    for _, v in ipairs(tbl) do
        if not hash[v] then
            res[#res + 1] = v -- you could print here instead of saving to result table if you wanted
            hash[v] = true
        end
    end
    return res
end

M.sudo_exec = function(cmd)
    vim.fn.inputsave()
    local password = vim.fn.inputsecret("Password: ")
    vim.fn.inputrestore()
    if not password or #password == 0 then
        vim.notify.error("Invalid password, sudo aborted!", {
            title = "Nvim IDE",
        })
        return false
    end
    vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
    if vim.v.shell_error ~= 0 then
        vim.notify.error("Shell error or invalid password, sudo aborted!", {
            title = "Nvim IDE",
        })
        return false
    end
    return true
end

M.sudo_write = function(tmpfile, filepath)
    if not tmpfile then
        tmpfile = vim.fn.tempname()
    end
    if not filepath then
        filepath = vim.fn.expand("%")
    end
    if not filepath or #filepath == 0 then
        vim.notify.error("No file name!", {
            title = "LVIM IDE",
        })
        return
    end
    local cmd = string.format("dd if=%s of=%s bs=1048576", vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath))
    vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
    if M.sudo_exec(cmd) then
        vim.notify.info(string.format('"%s" written!', filepath), {
            title = "LVIM IDE",
        })
        vim.cmd("e!")
    end
    vim.fn.delete(tmpfile)
end

M.file_exists = function(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

M.dir_exists = function(path)
    return M.file_exists(path)
end

M.read_file = function(file)
    local content
    local file_content_ok, _ = pcall(function()
        content = vim.fn.readfile(file)
    end)
    if not file_content_ok then
        return nil
    end
    if type(content) == "table" then
        return vim.fn.json_decode(content)
    else
        return nil
    end
end

M.write_file = function(file, content)
    local f = io.open(file, "w")
    if f ~= nil then
        if type(content) == "table" then
            content = vim.fn.json_encode(content)
        end
        f:write(content)
        f:close()
    end
end

M.delete_file = function(f)
    os.remove(f)
end

M.change_path = function()
    return vim.fn.input("Path: ", vim.fn.getcwd() .. "/", "file")
end

M.set_global_path = function()
    local path = M.change_path()
    vim.api.nvim_command("silent :cd " .. path)
end

M.set_window_path = function()
    local path = M.change_path()
    vim.api.nvim_command("silent :lcd " .. path)
end

return M
