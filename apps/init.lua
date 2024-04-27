vim.cmd [[
  syntax on
  filetype plugin on
  filetype indent on
]]
-- Ctrl+V for visual block
vim.o.cursorline = true
vim.o.incsearch = true
vim.o.number = true
vim.o.ruler = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.showmatch = true
vim.o.mouse = "a"
vim.o.laststatus = 2 
-- "*y and "*p for copying and pasting
vim.opt.clipboard = "unnamedplus"
-- "za" for folding/unfolding code blocks
vim.o.foldmethod = 'syntax'   
vim.o.foldlevel = 99          
vim.o.foldenable = true       

vim.api.nvim_set_keymap('n', 'çç', ':!pdflatex %<CR>', {noremap = true})
