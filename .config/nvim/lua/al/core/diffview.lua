return {
    -- TODO: If Diffview is open in another tab, this won't close it
    toggle = function(cmd)
        local diffview_open = false

        -- Iterate through all tabs
        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
            -- Get windows in this tab
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buf_name = vim.api.nvim_buf_get_name(buf)

                if buf_name:match("^diffview") then
                    diffview_open = true
                    break
                end
            end
            if diffview_open then break end
        end

        if diffview_open then
            vim.cmd [[DiffviewClose]]
        else
            vim.cmd(cmd)
        end
    end,
}
