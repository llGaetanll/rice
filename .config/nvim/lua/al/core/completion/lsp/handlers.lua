local util = require "al.core.completion.lsp.util"

local M = {}

M.definition = function(_, result, ctx, config)
  if result == nil or vim.tbl_isempty(result) then
    local _ = vim.lsp.log.info() and vim.lsp.log.info(ctx.method, "No location found")
    return nil
  end
  local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

  config = config or {}

  -- textDocument/definition can return Location or Location[]
  -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition
  if not vim.tbl_islist(result) then
    result = { result }
  end

  local title = "LSP locations"
  local items = vim.lsp.util.locations_to_items(result, client.offset_encoding)

  if config.on_list then
    assert(vim.is_callable(config.on_list), "on_list is not a function")
    config.on_list { title = title, items = items }
    return
  end
  if #result == 1 then
    util.jump(result[1], client, config)
    return
  end
  if config.loclist then
    vim.fn.setloclist(0, {}, " ", { title = title, items = items })
    vim.cmd.lopen()
  else
    vim.fn.setqflist({}, " ", { title = title, items = items })
    vim.cmd "botright copen"
  end
end

M.hover = function (_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
    -- Ignore result since buffer changed. This happens for slow language servers.
    return
  end
  if not (result and result.contents) then
    if config.silent ~= true then
      vim.notify('No information available')
    end
    return
  end
  local format = 'markdown'
  local contents ---@type string[]
  if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
    format = 'plaintext'
    contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
  else
    contents = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  end
  if vim.tbl_isempty(contents) then
    if config.silent ~= true then
      vim.notify('No information available')
    end
    return
  end
  return util.custom_open_floating_preview(contents, format, config)
end

return M
