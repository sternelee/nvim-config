-- or https://github.com/fgheng/winbar.nvim
local M = {}

vim.api.nvim_set_hl(0, "WinBarSignature", { fg = "#363636", bg = "#363636" })
vim.api.nvim_set_hl(0, "WinBarSigDoc", { fg = "#363636", bg = "#89ddff" })
vim.api.nvim_set_hl(0, "WinBarSigActParm", { fg = "#363636", bg = "#9f3838" })

local treesitter_context = function(width)
    -- if not packer_plugins["nvim-treesitter"] or packer_plugins["nvim-treesitter"].loaded == false then
    --   return " "
    -- end
    local type_patterns = {
        "class",
        "function",
        "method",
        "interface",
        "type_spec",
        "table",
        "if_statement",
        "for_statement",
        "for_in_statement",
        "call_expression",
        "comment",
    }

    if vim.o.ft == "json" then
        type_patterns = { "object", "pair" }
    end

    local f = require("nvim-treesitter").statusline({
        indicator_size = width,
        type_patterns = type_patterns,
    })
    local context = string.format("%s", f) -- convert to string, it may be a empty ts node

    -- lprint(context)
    if context == "vim.NIL" then
        return " "
    end

    return " " .. context
end

function M.eval()
    local columns = vim.api.nvim_get_option("columns")
    if not pcall(require, "lsp_signature") then
        return treesitter_context(columns)
    end
    local sig = require("lsp_signature").status_line(columns)

    if sig == nil or sig.label == nil or sig.range == nil then
        return treesitter_context(columns)
    end
    local label1 = sig.label
    local label2 = ""
    if sig.range then
        label1 = sig.label:sub(1, sig.range["start"] - 1)
        label2 = sig.label:sub(sig.range["end"] + 1, #sig.label)
    end
    local doc = sig.doc or ""
    if #doc + #sig.label >= columns then
        local trim = math.max(5, columns - #sig.label - #sig.hint - 10)
        doc = doc:sub(1, trim) .. "..."
        -- lprint(doc)
    end

    return "%#WinBarSignature#"
            .. label1
            .. "%*"
            .. "%#WinBarSigActParm#"
            .. sig.hint
            .. "%*"
            .. "%#WinBarSignature#"
            .. label2
            .. "%*"
            .. "%#WinBarSigDoc#"
            .. " "
            .. doc
        or "" .. "%*"
end

return M
