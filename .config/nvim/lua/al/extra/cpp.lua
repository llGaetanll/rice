local cpp_dir = "/home/al/files/programming/cpp"

-- Define the autocommand using Lua
vim.cmd([[
augroup CompileCpp
  autocmd!
  autocmd BufWritePost *.cpp if expand('%:p:h') == ']] .. cpp_dir .. [[' | execute '!g++ -std=c++11 -O2 -Wall ' .. expand('%') .. ' -o ' .. expand('%:r') | redraw! | endif
augroup END
]])
