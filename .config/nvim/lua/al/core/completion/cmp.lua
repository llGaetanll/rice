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

-- luasnip.snippets = {
--   html = {}
-- }
-- luasnip.snippets.javascript = luasnip.snippets.html
-- luasnip.snippets.javascriptreact = luasnip.snippets.html

luasnip.filetype_extend("javascript", { "html" })
luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })

require("luasnip/loaders/from_vscode").load({ include = { "html" } })
require("luasnip/loaders/from_vscode").lazy_load()

-- load vscode snippets
-- require("luasnip/loaders/from_vscode").lazy_load()

-- used for supertab
-- This function checks the position of the caret, and which column it is in for
-- the current line. It returns true if the caret is at the beginning of the
-- line, of if the character at the current position is whitespace.
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
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
		-- move through the autocomplete options with `ctrl + j/k`
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),

		-- scroll through the subwindow provided by cmp with `ctrl + b/f`
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

		-- pulls up autocompletion menu without needing to type
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

		-- close the autocompletion menu with `ctrl + e`
		-- TODO: change to ctrl + esc ?
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),

		-- `enter` selects the current item
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- `tab` cycles through the options
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
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
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. "  "
			kind.menu = "    " .. (strings[2] or "")

			return kind
		end,
	},
	sources = {
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
})
