local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

-- This function behaves as follows.
-- if the node selected in the tree is a directory: follow it
-- otherwise:
--    - if nvim_tree is the only buffer open, edit the file directly
--    - otherwise:
--        - if the tab is already open, switch to it
--        - otherwise: create a new tab for it
--
--        In either case, the cursor is brought back to the previous pane before
--        switching
local function custom_open()
	-- get the current node
	local node = require("nvim-tree.lib").get_node_at_cursor()

	-- mode up dir
	if node.name == ".." then
		require("nvim-tree.actions.root.change-dir").fn("..")

	-- expand or collapse dir
	elseif node.nodes then
		require("nvim-tree.lib").expand_or_collapse(node)

	-- if the node is a file
	else
		-- get number of windows in current tab page
		local num_wins = #vim.api.nvim_tabpage_list_wins(0)

		-- if we only have one window open, and it's nvim tree, don't create a new tab
		-- instead, open the file in the current window directly
		if num_wins == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			-- open the file in place
			require("nvim-tree.api").node.open.edit(node)

		-- if we have more than one window open
		else
			-- switch focus back from tree to file
			vim.api.nvim_command([[ wincmd p ]])

			-- switch to the tab if it exists, open in a new tab if not
			require("nvim-tree.api").node.open.tab_drop(node)
		end
	end
end

-- load the lsp icons from the theme
local lsp_icons = require("al.ui.theme").lsp_icons

local nvim_tree_icons = {
	git_placement = "after", -- put the git icon after the filename
	show = {
		folder_arrow = false,
	},
	glyphs = {
		default = "",
		symlink = "",
		folder = {
			arrow_open = "",
			arrow_closed = "",
			default = "",
			open = "",
			empty = "",
			empty_open = "",
			symlink = "",
			symlink_open = "",
		},
		git = {
			unstaged = "M",
			staged = "S",
			unmerged = "",
			renamed = "R",
			untracked = "U",
			deleted = "D",
			ignored = "",
		},
	},
}

-- Note: for a list of actions, see `:h nvim-tree-default-mappings`
--[[ local mappings = {
    -- `l` or `enter` opens a file/dir in a new tab
    {
      key = {"l", "<CR>"},

      action = "New Tab",

      -- open the file in a new tab
      action_cb = custom_open
    },

    -- `L` recursively opens a directory
    {
      key = "L", action = "expand_all"
    },

    -- `h` or `enter` closes a dir
    { key = {"h", "<CR>"}, action = "close_node" },

    -- `i` opens file left of current file
    { key = "i", action = "vsplit" },

    -- `o` opens file below current file
    { key = "o", action = "split" },
} ]]

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "NvimTree" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- Default mappings. Feel free to modify or remove as you wish.
	--
	-- BEGIN_DEFAULT_ON_ATTACH
	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
	vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
	vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
	vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "a", api.fs.create, opts("Create"))
	vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
	vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
	vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
	vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
	vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
	vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
	vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
	vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
	vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
	vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
	vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
	vim.keymap.set("n", "q", api.tree.close, opts("Close"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
	vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
	vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
	vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
	-- END_DEFAULT_ON_ATTACH

	-- custom nvim tree keybinds
	-- `custom_open` is a function that behaves like tabnew, but brings your
	-- cursor back to the previous window before switching to the new buffer
	vim.keymap.set("n", "<CR>", custom_open, opts("New Tab"))
	vim.keymap.set("n", "l", custom_open, opts("New Tab"))

	vim.keymap.set("n", "L", api.tree.expand_all, opts("Expand Node Recursively"))

	vim.keymap.set("n", "h", api.tree.close, opts("Close Node"))
	vim.keymap.set("n", "<CR>", api.tree.close, opts("Close Node"))

	vim.keymap.set("n", "i", api.node.open.vertical, opts("Vertical Split"))
	vim.keymap.set("n", "o", api.node.open.horizontal, opts("Horizontal Split"))
end

nvim_tree.setup({
	-- Note: for a full list of options, see `:h nvim-tree-setup`
	disable_netrw = true,
	hijack_cursor = true, -- no need to move left and right within tree
	update_cwd = true,

	-- attach keybinds
	on_attach = on_attach,

	-- NvimTree tab settings
	tab = {
		sync = {
			-- NvimTree stays open in all tabs
			open = true,

			-- NvimTree closes if closed in one tab
			close = true,
		},
	},

	-- NvimTree appearance settings
	renderer = {
		root_folder_label = ":t",
		icons = nvim_tree_icons,

		-- opened files are highlighted
		highlight_opened_files = "name",

		-- file color matches git file status
		highlight_git = true,
		highlight_modified = "name",

		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
	},

	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},

	diagnostics = {
		enable = true,
		show_on_dirs = false,
		icons = {
			error = lsp_icons.error,
			warning = lsp_icons.warn,
			hint = lsp_icons.hint,
			info = lsp_icons.info,
		},
	},

	actions = {
		open_file = {
			-- NvimTree won't close after opening a file
			quit_on_open = false,

			-- if `nvim .` is ran, NvimTree will launch to let you pick a file to open
			window_picker = { enable = true },
		},
	},

	view = {
		width = 30, -- width of the tree buffer
		side = "left", -- tree spawns on the left side of the screen
		-- hide_root_folder = true, -- don't display the root folder
		-- mappings = mappings,
		float = {
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},
})

-- auto close nvim tree if it is the last window in a tab, and there is more
-- than one tab
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		-- get number of windows in current tab page
		local num_wins = #vim.api.nvim_tabpage_list_wins(0)

    -- get number of tabpages
    local num_tabs = #vim.api.nvim_list_tabpages()

		-- current buffer name
		local bufname = vim.api.nvim_buf_get_name(0)

		if
			num_wins == 1 and num_tabs > 1
			and bufname:match("NvimTree_") ~= nil
			-- and modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0
		then
			vim.cmd("quit")
		end
	end,
})
