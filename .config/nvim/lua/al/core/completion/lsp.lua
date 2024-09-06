local lsp_ok, lsp = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
  return
end

local cmp_nvim_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_ok then
  return
end

-- load the lsp icons from the theme
local lsp_icons = require("al.ui.styles.util").lsp_icons

-- sign icons used by nvim lsp
local signs = {
  { name = "DiagnosticSignError", text = lsp_icons.error },
  { name = "DiagnosticSignWarn", text = lsp_icons.warn },
  { name = "DiagnosticSignHint", text = lsp_icons.hint },
  { name = "DiagnosticSignInfo", text = lsp_icons.info },
}

-- this is how lsp looks
local lsp_params = {
  -- disable virtual text
  virtual_text = true,

  -- show signs
  signs = {
    active = signs,
  },

  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    source = "always",
    header = "",
    prefix = "",
    border = "rounded",
  },
}

local window_styles = {
  border = "rounded",
  width = 50,
}

-- settings directory for language server parameters
local servers_dir = "al.core.completion.servers"

-- the list of language servers to set up
local servers = { "lua_ls" }

local function custom_goto_prev(severity)
  return function()
    vim.diagnostic.goto_prev { severity = severity }
  end
end

local function custom_goto_next(severity)
  return function()
    vim.diagnostic.goto_next { severity = severity }
  end
end

local lsp_gotos = {
  prev_error = custom_goto_prev(vim.diagnostic.severity.ERROR),
  next_error = custom_goto_next(vim.diagnostic.severity.ERROR),

  prev_warn = custom_goto_prev(vim.diagnostic.severity.WARN),
  next_warn = custom_goto_next(vim.diagnostic.severity.WARN),

  prev_info = custom_goto_prev(vim.diagnostic.severity.INFO),
  next_info = custom_goto_next(vim.diagnostic.severity.INFO),

  next_hint = custom_goto_prev(vim.diagnostic.severity.HINT),
  prev_hint = custom_goto_next(vim.diagnostic.severity.HINT),
}

local lsp_implementations = function()
  require("telescope.builtin").lsp_implementations()
end

local lsp_references = function()
  require("telescope.builtin").lsp_references()
end

local jump = function(location, client, config)
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

local goto_definition = function(_, result, ctx, config)
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
    jump(result[1], client, config)
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

local lsp_keymaps = {
  -- goto declaration of variable
  { mode = "n", keymap = "gD", action = vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },

  -- goto definition of variable
  { mode = "n", keymap = "gd", action = vim.lsp.buf.definition, desc = "[G]et [d]efinition" },

  -- get info about object
  { mode = "n", keymap = "K", action = vim.lsp.buf.hover, desc = "Get Info" },

  -- get signature of fn
  { mode = "n", keymap = "gS", action = vim.lsp.buf.signature_help, desc = "[G]et [S]ignature" },

  -- get implementation info
  { mode = "n", keymap = "gi", action = lsp_implementations, desc = "[G]et [i]mplementation" },

  -- rename an object
  { mode = "n", keymap = "<leader>rn", action = vim.lsp.buf.rename, desc = "[r]e[n]ame" },

  -- list all references of object
  { mode = "n", keymap = "gr", action = lsp_references, desc = "[g]et [r]eferences" },

  -- get code actions
  {
    mode = "n",
    keymap = "<leader>ca",
    action = vim.lsp.buf.code_action,
    desc = "[C]ode [A]ctions",
  },

  -- display info about errors
  {
    mode = "n",
    keymap = "<leader>f",
    action = vim.diagnostic.open_float,
    desc = "Display info about errors",
  },

  -- goto previous def
  { mode = "n", keymap = "[d", action = vim.diagnostic.goto_prev, desc = "Prev Def" },

  -- goto next def
  { mode = "n", keymap = "]d", action = vim.diagnostic.goto_next, desc = "Next Def" },

  -- goto previous error
  { mode = "n", keymap = "[e", action = lsp_gotos.prev_error, desc = "Prev Error" },

  -- goto next error
  { mode = "n", keymap = "]e", action = lsp_gotos.next_error, desc = "Next Error" },

  -- goto previous warning
  { mode = "n", keymap = "[w", action = lsp_gotos.prev_warn, desc = "Prev Warning" },

  -- goto next warning
  { mode = "n", keymap = "]w", action = lsp_gotos.next_warn, desc = "Next Warning" },

  -- goto previous info
  { mode = "n", keymap = "[i", action = lsp_gotos.prev_info, desc = "Prev Info" },

  -- goto next info
  { mode = "n", keymap = "]i", action = lsp_gotos.next_info, desc = "Next Info" },

  -- goto previous hint
  { mode = "n", keymap = "[h", action = lsp_gotos.prev_hint, desc = "Prev Hint" },

  -- goto next error
  { mode = "n", keymap = "]h", action = lsp_gotos.next_hint, desc = "Next Hint" },

  -- set loc list
  {
    mode = "n",
    keymap = "<leader>q",
    action = "<cmd>lua vim.diagnostic.setloclist()<CR>",
    desc = "Set Loc List",
  },
}

-- This is the function that is attached to a language server when it is attached to a buffer
local function on_attach(_, bufnr)
  -- key bindings for LSP
  for _, km in ipairs(lsp_keymaps) do
    -- keymap(bufnr, km.mode, km.keymap, km.action, { noremap = true, silent = true, desc = km.desc })
    vim.keymap.set(
      km.mode,
      km.keymap,
      km.action,
      { buffer = bufnr, noremap = true, silent = true, desc = "[LSP]: " .. km.desc }
    )
  end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

mason.setup { ensure_installed = servers }
mason_lsp.setup {}

mason_lsp.setup_handlers {
  function(server_name)
    -- directory of the current language server setting (if it exists)
    local server_dir = servers_dir .. "." .. server_name

    -- check for any language server specific settings
    -- if not, this will just be nil
    local conf_ok, conf = pcall(require, server_dir)

    lsp[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = conf_ok and conf.settings or nil,
      filetypes = (conf or {}).filetypes,
    }
  end,
}

-- setup the diagnostics
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- setup the diagnostics config
vim.diagnostic.config(lsp_params)

vim.lsp.handlers["textDocument/definition"] = goto_definition

-- setup the hover and signature help handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, window_styles)
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, window_styles)
