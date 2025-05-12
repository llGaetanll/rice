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

local lsp_keymaps = {
    -- goto definition of variable
    {
        mode = "n",
        keymap = "gd",
        action = vim.lsp.buf.definition,
        desc = "[G]et [d]efinition",
    },

    -- get info about object
    {
        mode = "n",
        keymap = "K",
        action = function()
            -- This config extends `vim.lsp.util.open_floating_preview.Opts`
            vim.lsp.buf.hover {
                border = "rounded",
                max_width = 50,
            }
        end,
        desc = "Get Info",
    },

    -- get signature of fn
    {
        mode = "n",
        keymap = "gS",
        action = vim.lsp.buf.signature_help,
        desc = "[G]et [S]ignature",
    },

    -- get implementation info
    {
        mode = "n",
        keymap = "gi",
        action = lsp_implementations,
        desc = "[G]et [i]mplementation",
    },

    -- rename an object
    { mode = "n", keymap = "<leader>rn", action = vim.lsp.buf.rename, desc = "[r]e[n]ame" },

    -- list all references of object
    {
        mode = "n",
        keymap = "gr",
        action = lsp_references,
        desc = "[g]et [r]eferences",
    },

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

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- settings directory for language server parameters
local servers_dir = "al.core.completion.servers"

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        -- Get the LSP client for this buffer. There could be more than one, but for now we just get the first.
        local client = vim.lsp.get_clients({ bufnr = event.buf, id = event.data.client_id })[1]
        local server_name = client.server_info.name

        -- Check for any language server specific settings
        local server_dir = servers_dir .. "." .. server_name
        local conf_ok, conf = pcall(require, server_dir)
        vim.lsp.config(server_name, {
            capabilities = capabilities,
            settings = conf_ok and conf.settings or nil,
            filetypes = conf_ok and conf.filetypes or nil,
        })

        -- LSP key bindings
        for _, km in ipairs(lsp_keymaps) do
            vim.keymap.set(
                km.mode,
                km.keymap,
                km.action,
                { buffer = event.buf, noremap = true, silent = true, desc = "[LSP]: " .. km.desc }
            )
        end

        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
                vim.lsp.buf.format { bufnr = event.buf }
            end,
        })
    end,
})

mason.setup { ensure_installed = servers }
mason_lsp.setup {}

local lsp_icons = require("al.ui.styles.util").lsp_icons

-- setup the diagnostics config
vim.diagnostic.config {
    -- disable virtual text
    virtual_text = true,

    -- show signs
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = lsp_icons.error,
            [vim.diagnostic.severity.WARN] = lsp_icons.warn,
            [vim.diagnostic.severity.HINT] = lsp_icons.hint,
            [vim.diagnostic.severity.INFO] = lsp_icons.info,
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
