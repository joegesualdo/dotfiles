require("neo-tree").setup({
  filesystem = {
    follow_current_file = true, -- Automatically focus the current file
    hijack_netrw_behavior = "open_default", -- Optional, recommended
  }
})
vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>")
