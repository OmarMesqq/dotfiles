vim.cmd [[
  syntax on
  filetype plugin on
  filetype indent on
]]

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
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_keymap('n', 'çç', ':!pdflatex %<CR>', {noremap = true})

