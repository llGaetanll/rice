-- need cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

-- need luasnip
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

-- add html snippets to all these filetypes
luasnip.filetype_extend("javascript", { "html" })
luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })

-- load vscode snippets
require("luasnip/loaders/from_vscode").lazy_load()

local symbol_map = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰀫",
}

cmp.setup {
    -- cmp needs a snippet engine, in our case this is luasnip
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
            border = "rounded",
        },
        documentation = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            border = "rounded",
        },
    },
    mapping = {
        -- scroll through the subwindow provided by cmp with `ctrl + j/k`
        ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

        -- pulls up autocompletion menu without needing to type
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

        -- close the autocompletion menu with `ctrl + e`
        -- TODO: change to ctrl + esc ?
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },

        -- `enter` selects the current item
        ["<CR>"] = cmp.mapping.confirm { select = true },

        -- `tab` cycles through the options
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<A-y>"] = require('minuet').make_cmp_map()
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local old_kind = vim_item.kind

            local format = require("lspkind").cmp_format {
                mode = "symbol",
                ellipsis_char = '…',
                preset = "codicons",
                symbol_map = symbol_map,
                menu = {
                    nvim_lsp = "[lsp]",
                    nvim_lua = "[lua]",
                    minuet = "[minuet]",
                    luasnip = "[luasnip]",
                    npm = "[npm]",
                    buffer = "[buf]",
                    path = "[path]",
                    cmdline = "[cmd]",
                },
                maxwidth = {
                    menu = 50,
                    abbr = 30
                },
            }

            local vim_item = format(entry, vim_item)
            local strings = vim.split(vim_item.kind, "%s", { trimempty = true })

            if vim_item.menu == "[minuet]" then
                vim_item.kind = " 󰊕 "
            else
                vim_item.kind = " " .. (strings[1] or "") .. " "
            end

            vim_item.menu = old_kind

            return vim_item
        end,
    },
    sources = {
        { name = "minuet" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
}
