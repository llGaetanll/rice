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


-- sign icons used by nvim lsp
local signs = {
  { name = "DiagnosticSignError", text = "x" },
  { name = "DiagnosticSignWarn", text = "!" },
  { name = "DiagnosticSignHint", text = "i" },
  { name = "DiagnosticSignInfo", text = "?" },
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
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}



-- the list of language servers to set up
local required_servers = {
  "rust_analyzer",  -- Rust
  "pyright",        -- Python
  "tsserver",       -- TypeScript
  "texlab",         -- LaTeX
  "gopls",          -- GoLang
  "clangd",         -- C/C++
  "jdtls",          -- Java
  "lua_ls"          -- Lua (sumneko_lua now deprecated)
}



-- TODO: move into WhichKey
local lsp_keymaps = {
  -- goto declaration of variable
  {
    mode = "n",
    keymap = "gD",
    action = "<cmd>lua vim.lsp.buf.declaration()<CR>",
    desc = "[G]oto [D]eclaration"
  },

  -- goto definition of variable
  {
    mode = "n",
    keymap = "gd",
    action = "<cmd>lua vim.lsp.buf.definition()<CR>",
    desc = "[G]et [d]efinition"
  },

  -- get info about object
  {
    mode = "n",
    keymap = "gI",
    action = "<cmd>lua vim.lsp.buf.hover()<CR>",
    desc = "[G]et [I]nfo"
  },

  -- get signature of fn
  {
    mode = "n",
    keymap = "gS",
    action = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    desc = "[G]et [S]ignature"
  },

  -- get implementation info
  {
    mode = "n",
    keymap = "gi",
    action = "<cmd>lua vim.lsp.buf.implementation()<CR>",
    desc = "[G]et [i]mplementation"
  },

  -- rename an object
  {
    mode = "n",
    keymap = "<leader>rn",
    action = "<cmd>lua vim.lsp.buf.rename()<CR>",
    desc = "[r]e[n]ame"
  },

  -- list all references of object
  {
    mode = "n",
    keymap = "gr",
    action = "<cmd>lua vim.lsp.buf.references()<CR>",
    desc = "[g]et [r]eferences"
  },

  -- get code actions
  {
    mode = "n",
    keymap = "<leader>ca",
    action = "<cmd>lua vim.lsp.buf.code_action()<CR>",
    desc = "[C]ode [A]ctions"
  },

  -- display info about errors
  {
    mode = "n",
    keymap = "<leader>f",
    action = "<cmd>lua vim.diagnostic.open_float()<CR>",
    desc = "Display info about errors"
  },

  -- goto previous error
  {
    mode = "n",
    keymap = "[d",
    action = '<cmd>lua vim.diagnostic.goto_prev {}<CR>',
    desc = "Prev Def"
  },

  -- goto next error
	{
    mode = "n",
    keymap = "]d",
    action = '<cmd>lua vim.diagnostic.goto_next {}<CR>',
    desc = "Next Def"
  },

  -- set loc list
  {
    mode = "n",
    keymap = "<leader>q",
    action = "<cmd>lua vim.diagnostic.setloclist()<CR>",
    desc = "Set Loc List"
  },
}


-- This is the function that is attached to a language server when it is attached to a buffer
local function on_attach(client, bufnr)
	-- TODO: refactor this into a method that checks if string in list
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

  -- load keymaps
  local keymap = vim.api.nvim_buf_set_keymap
	local opts = { noremap = true, silent = true }

  -- key bindings for LSP
  for _, km in ipairs(lsp_keymaps) do
    keymap(bufnr, km.mode, km.keymap, km.action, opts)
  end

	-- highlight document
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end

	illuminate.on_attach(client)
end



-- setup mason
mason.setup {
  -- tell mason which servers to install
  ensure_installed = required_servers,
}

-- setup mason-lspconfig
mason_lsp.setup {}



-- for each language server we setup any potential custom settings
for _, server in pairs(required_servers) do

  local capabilities = vim.lsp.protocol.make_client_capabilities()
	local opts = {
		on_attach = on_attach,
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
	}

  -- check for any language server specific settings
  -- if any are found, update the lsp options for that server
	local has_custom_opts, server_custom_opts = pcall(require, "al.core.completion.lsp.servers." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end

  -- spin up the language server
	lsp[server].setup(opts)
end



-- setup the diagnostics
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- setup the diagnostics config
vim.diagnostic.config(lsp_params)

-- setup the hover and signature help handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded",
    width = 60,
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded",
    width = 60,
  }
)
