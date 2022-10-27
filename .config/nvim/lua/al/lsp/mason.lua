local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

-- since this module is loaded from lsp.init.lua we can afford to make a direct
-- require call to it
local lsp = require("lspconfig")



-- the list of language servers to set up
local servers = {
  -- "json-lsp",
  -- "markdownlint",
  "texlab",
  "clangd",
  "rust_analyzer",
  "gopls",
  "pyright",
  "jdtls"
}



-- should be loaded in that order
mason.setup({
	ensure_installed = servers,
})

mason_lsp.setup();

for _, server in pairs(servers) do

	local opts = {
		on_attach = require("al.lsp.handlers").on_attach,
		capabilities = require("al.lsp.handlers").capabilities,
	}

  -- check for any language server specific settings
  -- if any are found, update the lsp options for that server
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end

  -- spin up the language server
	lsp[server].setup(opts)
end

