vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.autoread = true

-- For spaces instead of tabs
-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.shiftround = true
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true

-- For spaces instead of tabs
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while editing
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.opt.smartindent = true -- Enable smart indentation
vim.opt.autoindent = true -- Enable automatic indentation

-- Use Shift H or L to switch between buffers
vim.keymap.set("n", "H", ":bprevious<CR>")
vim.keymap.set("n", "L", ":bnext<CR>")
-- Press space and then h to clear current search highlights
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
