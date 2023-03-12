local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- This function is almost identical to the `tabnew` action provided
-- by nvim-tree but, when a file is selected, the cursor is brought
-- back to the previous pane before switch into the new buffer. 
local function open(node)
  -- mode up dir
  if node.name == ".." then
    require("nvim-tree.actions.root.change-dir").fn ".."

    -- expand or collapse dir
  elseif node.nodes then
    require("nvim-tree.lib").expand_or_collapse(node)

    -- open node in new tab
  else
    -- switch focus back from tree to file
    vim.api.nvim_command [[ wincmd p ]]

    -- call nvim-tree tabnew on the node
    require("nvim-tree.api").node.open.tab(node)
  end
end



local nvim_tree_icons = {
  git_placement = "after", -- put the git icon after the filename
  show = {
    folder_arrow = false
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
      ignored = ""
    },
  },
}



local mappings = {
  -- Note: for a list of actions, see `:h nvim-tree-default-mappings`
  list = {

    -- `l` or `enter` opens a file/dir in a new tab
    {
      key = {"l", "<CR>"},

      action = "New Tab",

      -- open the file in a new tab
      action_cb = open
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
  },
}



nvim_tree.setup {
  -- Note: for a full list of options, see `:h nvim-tree-setup`
  disable_netrw = true,
  hijack_cursor = true, -- no need to move left and right within tree
  update_cwd = true,

  -- NvimTree tab settings
  tab = {
    sync = {
      -- NvimTree stays open in all tabs
      open = true,

      -- NvimTree closes if closed in one tab
      close = true,
    }
  },

  -- NvimTree appearance settings
  renderer = {
    root_folder_label = ":t",
    icons = nvim_tree_icons,

    -- opened files are highlighted
    highlight_opened_files = "all",

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
    ignore_list = {}
  },

  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      error = "",
      warning = "",
      hint = "",
      info = "?"
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
    mappings = mappings,
    float = {
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      }
    }
  },
}


-- open nvim tree on startup
-- see: https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()

  -- switch focus back from tree to file
  vim.api.nvim_command [[ wincmd p ]]
end

vim.api.nvim_create_autocmd({ "VimEnter "}, { callback = open_nvim_tree })


-- auto close nvim tree if it is the last buffer
-- see: https://github.com/nvim-tree/nvim-tree.lua/issues/1005#issuecomment-1183468091

-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for _,v in pairs(bufs) do
        if v.name:match("NvimTree_") == nil then
            t = t + 1
        end
    end
    return t
end

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        -- get number of windows in current tab page
        num_wins = #vim.api.nvim_tabpage_list_wins(0)

        if num_wins == 1 and
        vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
        modifiedBufs(vim.fn.getbufinfo({bufmodified = 1})) == 0 then
            vim.cmd "quit"
        end
    end
})
