return {
  toggle = function(cmd)
    local buf_name = vim.api.nvim_buf_get_name(0)

    if buf_name:match "^diffview" then
      vim.cmd [[DiffviewClose]]
    else
      vim.cmd(cmd)
    end
  end
}
