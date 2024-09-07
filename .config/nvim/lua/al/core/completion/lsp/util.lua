local M = {}

M.jump = function(location, client, config)
  local uri = location.uri or location.targetUri
  local bufnr = vim.uri_to_bufnr(uri)

  -- for each tab
  for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
    -- for each window in each tab
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
      if vim.api.nvim_win_get_buf(winid) == bufnr then
        vim.api.nvim_set_current_tabpage(tabnr) -- Switch to the tab with the buffer
        vim.api.nvim_set_current_win(winid) -- Switch to the window with the buffer
        vim.lsp.util.jump_to_location(location, client.offset_encoding, config.reuse_win)
        return
      end
    end
  end

  vim.cmd "tabnew"
  vim.lsp.util.jump_to_location(location, client.offset_encoding, config.reuse_win)
end

return M
