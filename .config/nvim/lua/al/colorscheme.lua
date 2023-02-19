-- set colorscheme here
local colorscheme = "melange"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end



-- custom highlight groups
-- use `:hi` to see all highlight groups

-- hide tildes at end of buffers, and remove vertical right indicators to
-- seamless nvim-tree integration
-- vim.cmd [[ set fillchars=eob:\ ,vertright:\ ]]
vim.cmd [[ set fillchars=eob:\ ]]


-- make NvimTree's background color inline with floating windows
-- vim.cmd [[ highlight link NvimTreeNormal NormalFloat ]]

-- vim.cmd [[ highlight NvimTreeNormal guibg=#FF0000 ]]
-- vim.cmd [[ highlight NvimTreeEndOfBuffer guibg=#FF0000 ]]

-- update the nvim tree split highlight group
-- this code copies the background color of the NormalFloat highlight group and
-- sets the background and foreground of the split highlight group to it. This
-- essentially removes the ugly vertical line for NvimTree's buffer only.

nf = vim.api.nvim_get_hl_by_name('NormalFloat', true)
n = vim.api.nvim_get_hl_by_name('Normal', true)

vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', {
  fg = n.background,
  bg = n.background
})

-- set nvim-tree's background color to match floating windows
vim.api.nvim_set_hl(0, 'NvimTreeNormal', {
  bg = nf.background
})

vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', {
  bg = nf.background
})

-- fix splits colors for darkplus theme
if colorscheme == "darkplus" then
  ws = vim.api.nvim_get_hl_by_name('WinSeparator', true)
  vim.api.nvim_set_hl(0, 'WinSeparator', {
    bg = ws.foreground,
    fg = ws.background
  })
end
