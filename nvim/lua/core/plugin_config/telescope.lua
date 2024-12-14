vim.keymap.set('n', '<c-p>', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<Leader><Space>', require('telescope.builtin').oldfiles, {})
vim.keymap.set('n', '<Leader>fg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<Leader>fh', require('telescope.builtin').help_tags, {})
