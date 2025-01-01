-- General Vim configurations
 vim.cmd [[
   syntax on
   filetype plugin on
   filetype indent on
   set expandtab sw=4 sts=4
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
-- 
vim.o.termguicolors = true
vim.cmd [[colorscheme desert]] -- Default scheme

-- KEYBINDS 
vim.g.mapleader = " "  
vim.api.nvim_set_keymap('n', 'çç', ':!pdflatex %<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader><Tab>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })


-- Packer (plugin manager) and plugins setup
vim.cmd [[packadd packer.nvim]]
require('plugins')

require('nvim-tree').setup {}

require('bufferline').setup {
  options = {
    numbers = "ordinal",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = 'M',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      }
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "slant",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  }
}
