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

M.hover = function(_, result, ctx, config)
  local _, winnr = vim.lsp.handlers.hover(_, result, ctx, config)

  vim.api.nvim_set_option_value(
    "winhighlight",
    "Normal:HoverNormal,FloatBorder:HoverBorder",
    { win = winnr }
  )
end

return M
