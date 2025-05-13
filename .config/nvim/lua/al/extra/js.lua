-- Adds an autocmd to format on save any js/ts/jsx/tsx file with prettier.
-- Assumes that prettier is installed

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
    callback = function()
        vim.cmd("silent !prettier --write %")
    end,
})
