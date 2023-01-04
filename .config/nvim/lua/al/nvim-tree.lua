local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local nvim_tree_icons = {
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
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      untracked = "U",
      deleted = "",
      ignored = "◌", },
  },
}

nvim_tree.setup {
  -- Note: for a full list of options, see `:h nvim-tree-setup`
  disable_netrw = true,
  hijack_cursor = true, -- no need to move left and right within tree
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  open_on_tab = true, -- NvimTree stays open in new tabs
  renderer = {
    root_folder_modifier = ":t",
    icons = nvim_tree_icons,
    highlight_opened_files = "none",
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
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
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
    mappings = {
      -- Note: for a list of actions, see `:h nvim-tree-default-mappings`
      list = {
        { key = {"l", "<CR>"}, action = "tabnew" },      -- `l` or `enter` opens a file/dir in a new tab
        { key = {"h", "<CR>"}, action = "close_node" },  -- `h` or `enter` closes a dir

        { key = "L", action = "vsplit" },                 -- `shift + l` opens file in horizontal split
        { key = "<C-l>", action = "split" },            -- `ctrl + l` opens file in vertical split
      },
    },
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



-- auto close nvim tree if it is the last buffer
-- see: https://github.com/nvim-tree/nvim-tree.lua/issues/1005#issuecomment-1183468091

-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for k,v in pairs(bufs) do
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
