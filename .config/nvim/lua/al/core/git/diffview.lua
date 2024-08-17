local M = {}

M.toggle = function()
    local buf_name = vim.api.nvim_buf_get_name(0)

    if buf_name:match "^diffview" then
        vim.cmd [[DiffviewClose]]
    else
        vim.cmd [[DiffviewOpen]]
    end
end

M.opts = {
    enhanced_diff_hl = true,
}

return M
