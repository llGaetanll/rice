return {
    {
        mode = "n",
        keymap = "<leader><Space>",
        action = "<cmd>WhichKey<CR>",
        desc = "List all keybinds",
    },

    -- resize panes
    {
        mode = "n",
        keymap = "<C-Up>",
        action = "<cmd>resize -2<CR>",
        desc = "Resize windows",
    },
    {
        mode = "n",
        keymap = "<C-Down>",
        action = "<cmd>resize +2<CR>",
        desc = "Resize windows",
    },
    {
        mode = "n",
        keymap = "<C-Left>",
        action = "<cmd>vertical resize -2<CR>",
        desc = "Resize windows",
    },
    {
        mode = "n",
        keymap = "<C-Right>",
        action = "<cmd>vertical resize +2<CR>",
        desc = "Resize windows",
    },

    -- Navigate Panes
    {
        mode = "n",
        keymap = "<Up>",
        action = "<C-w>k",
        desc = "Navigate to window above",
    },
    {
        mode = "n",
        keymap = "<Down>",
        action = "<C-w>j",
        desc = "Navigate to window below",
    },
    {
        mode = "n",
        keymap = "<Left>",
        action = "<C-w>h",
        desc = "Navigate to left window",
    },
    {
        mode = "n",
        keymap = "<Right>",
        action = "<C-w>l",
        desc = "Navigate to right window",
    },

    -- Move Panes
    {
        mode = "n",
        keymap = "<S-Up>",
        action = "<C-w>K",
        desc = "Move window above",
    },
    {
        mode = "n",
        keymap = "<S-Down>",
        action = "<C-w>J",
        desc = "Move window below",
    },
    {
        mode = "n",
        keymap = "<S-Left>",
        action = "<C-w>H",
        desc = "Move window left",
    },
    {
        mode = "n",
        keymap = "<S-Right>",
        action = "<C-w>L",
        desc = "Move window right",
    },

    -- Navigate Tabs
    {
        mode = "n",
        keymap = "<c-l>",
        action = "gt",
        desc = "next tab",
    },
    {
        mode = "n",
        keymap = "<c-h>",
        action = "gT",
        desc = "prev tab",
    },

    -- Clear search highlighting
    {
        mode = "n",
        keymap = "<Esc>",
        action = ":noh<CR>",
        desc = "clear search highlight",
    },

    -- Stay in visual mode after indenting
    {
        mode = "v",
        keymap = "<",
        action = "<gv",
        desc = "indent less",
    },
    {
        mode = "v",
        keymap = ">",
        action = ">gv",
        desc = "indent more",
    },

    {
        mode = "v", -- visual mode
        keymap = "<c-y>",
        action = '"+y',
        desc = "copy to system clipboard",
    },
    {
        mode = "x", -- visual block
        keymap = "<c-y>",
        action = '"+y',
        desc = "copy to system clipboard",
    },

    -- NvimTree
    {
        mode = "n",
        keymap = "<leader>t",
        action = "<cmd>NvimTreeToggle<CR>",
        desc = "[t]oggle NvimTree",
    },
    {
        mode = "n",
        keymap = "<leader>T",
        action = "<cmd>NvimTreeFocus<CR>",
        desc = "Focus NvimTree",
    },

    -- Markdown
    {
        mode = "n",
        keymap = "<leader>mp",
        action = "<cmd>MarkdownPreview<CR>",
        desc = "Toggle Markdown Preview",
    },

    -- Diffview
    {
        mode = "n",
        keymap = "<leader>dd",
        action = require("al.core.git.diffview").toggle,
        desc = "Diffview Toggle",
    },
    {
        mode = "n",
        keymap = "<leader>dr",
        action = "<cmd>DiffviewRefresh<CR>",
        desc = "[D]iffview [R]efresh",
    },
    {
        mode = "n",
        keymap = "<leader>dh",
        action = "<cmd>DiffviewFileHistory<CR>",
        desc = "[D]iffview File [H]istory",
    },

    -- Telescope
    {
        mode = "n",
        keymap = "<leader>ff",
        action = require("telescope.builtin").find_files,
        desc = "[f]ind [f]iles",
    },
    {
        mode = "n",
        keymap = "<leader>fg",
        action = require("telescope.builtin").live_grep,
        desc = "[f]ile [g]rep",
    },
    {
        mode = "n",
        keymap = "<leader>fb",
        action = require("telescope.builtin").buffers,
        desc = "[f]ind [b]uffers",
    },
    {
        mode = "n",
        keymap = "<leader>fh",
        action = require("telescope.builtin").help_tags,
        desc = "[f]ind [h]elp",
    },
    {
        mode = "n",
        keymap = "<leader>gh",
        action = require("telescope.builtin").highlights,
        desc = "[g]et [h]ighlights",
    },
    {
        mode = "n",
        keymap = "<leader>kb",
        action = require("telescope.builtin").keymaps,
        desc = "[k]ey [b]indings",
    },
}
