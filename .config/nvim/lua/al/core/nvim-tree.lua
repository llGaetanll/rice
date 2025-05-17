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
    local node = require("nvim-tree.api").tree.get_node_under_cursor()

    -- mode up dir
    if node.name == ".." then
        require("nvim-tree.actions.root.change-dir").fn ".."

        -- expand or collapse dir
    elseif node.nodes then
        require("nvim-tree.api").node.open.edit(node)

        -- if the node is a file
    else
        -- get number of windows in current tab page
        local num_wins = #vim.api.nvim_tabpage_list_wins(0)

        -- if we only have one window open, and it's nvim tree, don't create a new tab
        -- instead, open the file in the current window directly
        if num_wins == 1 and vim.api.nvim_buf_get_name(0):match "NvimTree_" ~= nil then
            -- open the file in place
            require("nvim-tree.api").node.open.edit(node)

            -- if we have more than one window open
        else
            -- switch focus back from tree to file
            vim.api.nvim_command [[ wincmd p ]]

            -- switch to the tab if it exists, open in a new tab if not
            require("nvim-tree.api").node.open.tab_drop(node)
        end
    end
end

local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return {
            desc = "NvimTree" .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    -- custom nvim tree keybinds
    vim.keymap.set("n", "l", custom_open, opts "Open file")

    vim.keymap.set("n", "L", api.tree.expand_all, opts "Expand Node Recursively")
    vim.keymap.set("n", "H", api.tree.collapse_all, opts "Collapse Node Recursively")
    vim.keymap.set("n", "R", api.tree.reload, opts "Reload")

    vim.keymap.set("n", "<ESC>", api.tree.close, opts "Close Node")

    vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Filter: Dotfiles")
    vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Filter: Git Ignore")

    vim.keymap.set("n", "i", api.node.open.vertical, opts "Vertical Split")
    vim.keymap.set("n", "o", api.node.open.horizontal, opts "Horizontal Split")

    vim.keymap.set("n", "d", api.fs.cut, opts "Cut file")
    vim.keymap.set("n", "y", api.fs.copy.node, opts "Copy file")
    vim.keymap.set("n", "p", api.fs.paste, opts "Paste file")
    vim.keymap.set("n", "C", api.fs.clear_clipboard, opts "Clear Clipboard")

    vim.keymap.set("n", "r", api.fs.rename, opts "Rename file")
    vim.keymap.set("n", "a", api.fs.create, opts "New file")
    vim.keymap.set("n", "D", api.fs.remove, opts "Delete file")
end

-- Load the lsp icons from the theme
local icons = require "al.ui.styles.icons"

-- See `:h nvim-tree-setup`
return function()
    require("nvim-tree").setup({
        disable_netrw = true,
        hijack_cursor = true,  -- Don't move left and right within tree
        update_cwd = true,
        on_attach = on_attach, -- Attach keybinds

        tab = {
            sync = {
                open = true,  -- NvimTree stays open in all tabs
                close = true, -- NvimTree closes if closed in one tab
            },
        },

        -- Appearance settings
        renderer = {
            root_folder_label = ":t",
            icons = {
                git_placement = "after", -- Put the git icon after the filename
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
            },

            -- opened files are highlighted
            highlight_opened_files = "name",

            -- file color matches git file status
            highlight_git = "none",
            highlight_modified = "name",
            highlight_diagnostics = "name",

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
            update_root = false,
            ignore_list = {},
        },

        diagnostics = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
            icons = {
                error = icons.error,
                warning = icons.warn,
                hint = icons.hint,
                info = icons.info,
            },
        },

        actions = {
            open_file = {
                window_picker = { enable = true }, -- If `nvim .` is ran, NvimTree will launch to let you pick a file to open
            },
        },

        view = {
            width = 30,    -- Width of the tree buffer
            side = "left", -- Tree spawns on the left side of the screen
        },
    })

    -- Close nvim-tree if it's the last buffer in a tab, unless it's the only buffer
    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            local numtabs = vim.fn.tabpagenr("$")
            local tabnr = vim.fn.tabpagenr()

            -- list of buffers on the current tab page
            local bufs = vim.fn.tabpagebuflist(tabnr)
            local bufname = vim.api.nvim_buf_get_name(0)

            if numtabs > 1 and #bufs == 1 and bufname:match("NvimTree_") then
                vim.cmd "quit"
            end
        end
    })
end
