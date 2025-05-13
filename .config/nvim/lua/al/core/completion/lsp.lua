local lsp_ok, _ = pcall(require, "lspconfig")
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

local hover = function()
    -- Extends `vim.lsp.util.open_floating_preview.Opts`
    vim.lsp.buf.hover {
        border = "rounded",
        max_width = 50,
    }
end

local lsp_keymaps = {
    { mode = "n", keymap = "gd",         action = vim.lsp.buf.definition,     desc = "[g]oto [d]efinition", },
    { mode = "n", keymap = "K",          action = hover,                      desc = "Get object Info", },
    { mode = "n", keymap = "gS",         action = vim.lsp.buf.signature_help, desc = "[g]et [S]ignature", },
    { mode = "n", keymap = "gi",         action = lsp_implementations,        desc = "[g]et [i]mplementation", },
    { mode = "n", keymap = "<leader>rn", action = vim.lsp.buf.rename,         desc = "[r]e[n]ame" },
    { mode = "n", keymap = "gr",         action = lsp_references,             desc = "[g]et [r]eferences", },
    { mode = "n", keymap = "<leader>ca", action = vim.lsp.buf.code_action,    desc = "[c]ode [a]ctions", },
    { mode = "n", keymap = "<leader>f",  action = vim.diagnostic.open_float,  desc = "Display info about errors", },
    { mode = "n", keymap = "<leader>q",  action = vim.diagnostic.setloclist,  desc = "Set Loc List", },

    { mode = "n", keymap = "[d",         action = vim.diagnostic.goto_prev,   desc = "Prev Def" },
    { mode = "n", keymap = "]d",         action = vim.diagnostic.goto_next,   desc = "Next Def" },

    { mode = "n", keymap = "[e",         action = lsp_gotos.prev_error,       desc = "Prev Error" },
    { mode = "n", keymap = "]e",         action = lsp_gotos.next_error,       desc = "Next Error" },

    { mode = "n", keymap = "[w",         action = lsp_gotos.prev_warn,        desc = "Prev Warning", },
    { mode = "n", keymap = "]w",         action = lsp_gotos.next_warn,        desc = "Next Warning", },

    { mode = "n", keymap = "[i",         action = lsp_gotos.prev_info,        desc = "Prev Info" },
    { mode = "n", keymap = "]i",         action = lsp_gotos.next_info,        desc = "Next Info" },

    { mode = "n", keymap = "[h",         action = lsp_gotos.prev_hint,        desc = "Prev Hint" },
    { mode = "n", keymap = "]h",         action = lsp_gotos.next_hint,        desc = "Next Hint" },
}

mason.setup {}
mason_lsp.setup {}

local function on_attach(client, bufnr)
    -- LSP key bindings
    for _, km in ipairs(lsp_keymaps) do
        vim.keymap.set(
            km.mode,
            km.keymap,
            km.action,
            { buffer = bufnr, noremap = true, silent = true, desc = "[LSP]: " .. km.desc }
        )
    end

    -- Format on save
    if client.name == "ts_ls" then
        -- TypeScript LSP should not handle formatting, prettier should
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
            callback = function()
                vim.cmd("silent !prettier --write %")
            end,
        })
    else
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end

-- TODO:
-- 1. We can probably do better than a hardcoded list of servers
-- 2. Loading the settings upfront for each server like this is wasteful. It
--    would be better if they were lazily loaded (i.e. when we open a file of the
--    right type) but for the life of me, I cannot figure out how to do this.
local servers = { "rust_analyzer", "lua_ls", "ts_ls" }

-- settings directory for language server parameters
local servers_dir = "al.core.completion.servers"

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

for _, server in ipairs(servers) do
    local server_dir = servers_dir .. "." .. server
    local conf_ok, conf = pcall(require, server_dir)
    vim.lsp.config(server, {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = conf_ok and conf.settings or nil,
        filetypes = conf_ok and conf.filetypes or nil,
    })
end

-- setup the diagnostics config
local icons = require "al.ui.styles.icons"
vim.diagnostic.config {
    -- disable virtual text
    virtual_text = true,

    -- show signs
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.error,
            [vim.diagnostic.severity.WARN] = icons.warn,
            [vim.diagnostic.severity.HINT] = icons.hint,
            [vim.diagnostic.severity.INFO] = icons.info,
        },
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
