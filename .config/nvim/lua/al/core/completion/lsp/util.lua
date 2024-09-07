local M = {}

--- Closes the preview window
---
---@param winnr integer window id of preview window
---@param bufnrs table|nil optional list of ignored buffers
local function close_preview_window(winnr, bufnrs)
  vim.schedule(function()
    -- exit if we are in one of ignored buffers
    if bufnrs and vim.list_contains(bufnrs, vim.api.nvim_get_current_buf()) then
      return
    end

    local augroup = 'preview_window_' .. winnr
    pcall(vim.api.nvim_del_augroup_by_name, augroup)
    pcall(vim.api.nvim_win_close, winnr, true)
  end)
end

--- Creates autocommands to close a preview window when events happen.
---
---@param events table list of events
---@param winnr integer window id of preview window
---@param bufnrs table list of buffers where the preview window will remain visible
---@see autocmd-events
local function close_preview_autocmd(events, winnr, bufnrs)
  local augroup = vim.api.nvim_create_augroup('preview_window_' .. winnr, {
    clear = true,
  })

  -- close the preview window when entered a buffer that is not
  -- the floating window buffer or the buffer that spawned it
  vim.api.nvim_create_autocmd('BufEnter', {
    group = augroup,
    callback = function()
      close_preview_window(winnr, bufnrs)
    end,
  })

  if #events > 0 then
    vim.api.nvim_create_autocmd(events, {
      group = augroup,
      buffer = bufnrs[2],
      callback = function()
        close_preview_window(winnr)
      end,
    })
  end
end

local function find_window_by_var(name, value)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.F.npcall(vim.api.nvim_win_get_var, win, name) == value then
      return win
    end
  end
end

M.custom_open_floating_preview = function (contents, syntax, opts)
  vim.validate({
    contents = { contents, 't' },
    syntax = { syntax, 's', true },
    opts = { opts, 't', true },
  })

  opts = opts or {}
  opts.wrap = opts.wrap ~= false -- wrapping by default
  opts.focus = opts.focus ~= false
  opts.close_events = opts.close_events or { 'CursorMoved', 'CursorMovedI', 'InsertCharPre' }

  local bufnr = vim.api.nvim_get_current_buf()

  -- check if this popup is focusable and we need to focus
  if opts.focus_id and opts.focusable ~= false and opts.focus then
    -- Go back to previous window if we are in a focusable one
    local current_winnr = vim.api.nvim_get_current_win()
    if vim.F.npcall(vim.api.nvim_win_get_var, current_winnr, opts.focus_id) then
      vim.api.nvim_command('wincmd p')
      return bufnr, current_winnr
    end
    do
      local win = find_window_by_var(opts.focus_id, bufnr)
      if win and vim.api.nvim_win_is_valid(win) and vim.fn.pumvisible() == 0 then
        -- focus and return the existing buf, win
        vim.api.nvim_set_current_win(win)
        vim.api.nvim_command('stopinsert')
        return vim.api.nvim_win_get_buf(win), win
      end
    end
  end

  -- check if another floating preview already exists for this buffer
  -- and close it if needed
  local existing_float = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_floating_preview')
  if existing_float and vim.api.nvim_win_is_valid(existing_float) then
    vim.api.nvim_win_close(existing_float, true)
  end

  -- Create the buffer
  local floating_bufnr = vim.api.nvim_create_buf(false, true)

  -- Set up the contents, using treesitter for markdown
  local do_stylize = syntax == 'markdown' and vim.g.syntax_on ~= nil
  if do_stylize then
    local width = vim.lsp.util._make_floating_popup_size(contents, opts)
    contents = vim.lsp.util._normalize_markdown(contents, { width = width })
    vim.bo[floating_bufnr].filetype = 'markdown'
    vim.treesitter.start(floating_bufnr)
    vim.api.nvim_buf_set_lines(floating_bufnr, 0, -1, false, contents)
  else
    -- Clean up input: trim empty lines
    contents = vim.split(table.concat(contents, '\n'), '\n', { trimempty = true })

    if syntax then
      vim.bo[floating_bufnr].syntax = syntax
    end
    vim.api.nvim_buf_set_lines(floating_bufnr, 0, -1, true, contents)
  end

  -- Compute size of float needed to show (wrapped) lines
  if opts.wrap then
    opts.wrap_at = opts.wrap_at or vim.api.nvim_win_get_width(0)
  else
    opts.wrap_at = nil
  end
  local width, height = vim.lsp.util._make_floating_popup_size(contents, opts)

  local float_option = vim.lsp.util.make_floating_popup_options(width, height, opts)
  local floating_winnr = vim.api.nvim_open_win(floating_bufnr, false, float_option)

  if do_stylize then
    vim.wo[floating_winnr].conceallevel = 2
  end
  -- disable folding
  vim.wo[floating_winnr].foldenable = false
  -- soft wrapping
  vim.wo[floating_winnr].wrap = opts.wrap

  vim.bo[floating_bufnr].modifiable = false
  vim.bo[floating_bufnr].bufhidden = 'wipe'

  vim.api.nvim_buf_set_keymap(
    floating_bufnr,
    'n',
    'q',
    '<cmd>bdelete<cr>',
    { silent = true, noremap = true, nowait = true }
  )

  close_preview_autocmd(opts.close_events, floating_winnr, { floating_bufnr, bufnr })

  -- save focus_id
  if opts.focus_id then
    vim.api.nvim_win_set_var(floating_winnr, opts.focus_id, bufnr)
  end
  vim.api.nvim_buf_set_var(bufnr, 'lsp_floating_preview', floating_winnr)

  return floating_bufnr, floating_winnr
end

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
