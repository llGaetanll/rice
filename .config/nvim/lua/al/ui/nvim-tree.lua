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
local lsp_icons = require("al.ui.theme.util").lsp_icons

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "NvimTree" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- custom nvim tree keybinds
  vim.keymap.set("n", "l", custom_open, opts("Open file"))

  vim.keymap.set("n", "L", api.tree.expand_all, opts("Expand Node Recursively"))
  vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse Node Recursively"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Reload"))

  vim.keymap.set("n", "<ESC>", api.tree.close, opts("Close Node"))

  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))

  vim.keymap.set("n", "i", api.node.open.vertical, opts("Vertical Split"))
  vim.keymap.set("n", "o", api.node.open.horizontal, opts("Horizontal Split"))

  vim.keymap.set("n", "d", api.fs.cut, opts("Cut file"))
  vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy file"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste file"))

  vim.keymap.set("n", "r", api.fs.rename, opts("Rename file"))
  vim.keymap.set("n", "a", api.fs.create, opts("New file"))
  vim.keymap.set("n", "D", api.fs.remove, opts("Delete file"))
end

-- width and height ratio of the nvim-tree floating window (with respect to
-- screen width and height)
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.4

return {
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
    icons = {
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
    },

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
      -- NvimTree will close after opening a file
      quit_on_open = true,

      -- if `nvim .` is ran, NvimTree will launch to let you pick a file to open
      window_picker = { enable = true },
    },
  },

  view = {
    width = 30,  -- width of the tree buffer
    side = "left", -- tree spawns on the left side of the screen
    -- hide_root_folder = true, -- don't display the root folder
    -- mappings = mappings,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

        return {
          border = "none",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
  },
}
