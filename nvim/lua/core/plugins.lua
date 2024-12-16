-- Set the path for the lazy.nvim plugin directory
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is not installed, and install it if needed
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",                     -- Clone the repository
        "--filter=blob:none",        -- Minimize data by excluding file contents
        "https://github.com/folke/lazy.nvim.git", -- URL of lazy.nvim repository
        "--branch=stable",           -- Use the latest stable release
        lazypath,                    -- Path to clone the repository
    })
end

-- Prepend the lazy.nvim path to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Initialize and configure lazy.nvim plugins
require("lazy").setup({
    -- File explorer with dependencies
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x", -- Use the version 3.x branch
        dependencies = {
            "nvim-lua/plenary.nvim",       -- Common utilities
            "nvim-tree/nvim-web-devicons", -- Adds file type icons
            "MunifTanjim/nui.nvim",        -- UI components
        },
        config = function()
            require("core.plugin_config.neo-tree") -- Load custom configuration
        end,
    },

    -- Popular Gruvbox color scheme for Neovim
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- High priority for color schemes
        opts = {}, -- Default options
        config = function()
            require("core.plugin_config.gruvbox") -- Load custom configuration
        end,
    },

    -- Customizable status line for Neovim
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- Adds file type icons
        },
        event = "BufReadPre", -- Load on buffer read
        config = function()
            require("core.plugin_config.lualine") -- Load custom configuration
        end,
    },

    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },

      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
          files = {
            fzf_bin = "sk", -- Use skim for file finding
          },
          grep = {
            -- rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
            fzf_bin = "sk", -- Use skim for live grep
          },
        })
        vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Fzf Files" })
        -- vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require'fzf-lua'.files()<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require'fzf-lua'.live_grep()<CR>", { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ff', require('fzf-lua').files, { noremap = true, silent = true, desc = "Find Files" })
        vim.keymap.set('n', '<leader>fg', require('fzf-lua').live_grep, { noremap = true, silent = true, desc = "Live Grep" })


      end
    },
    -- Setup for LSP and completion frameworks
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim", -- Mason LSP bridge
            "neovim/nvim-lspconfig", -- LSP client configurations
        },
        config = function()
            require("core.plugin_config.lsp_general") -- Load custom configuration
        end,
    },
    {
      'Exafunction/codeium.vim',
      event = 'BufEnter',
      config = function()
        -- this is how you toggle codeium
        vim.g.codeium_enabled = true
        vim.g.codeium_disable_bindings = 1

        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set("i", "<C-g>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true })
        vim.keymap.set("i", "<C-;>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true })
        vim.keymap.set("i", "<C-,>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true })
        vim.keymap.set("i", "<C-x>", function()
            return vim.fn["codeium#Clear"]()
        end, { expr = true })
      end
    }
})
-- END Lazy plugin manager
