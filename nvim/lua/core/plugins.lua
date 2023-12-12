local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					{
						-- A UI for nvim-dap which provides a good out of the box configuration.
						"mfussenegger/nvim-dap",
						config = function()
							require("core.plugin_config.nvim-dap")
						end,
					},
				},
			},
		},
		config = function()
			require("core.plugin_config.rust-tools")
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("core.plugin_config.oil")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",

		config = function()
			require("core.plugin_config.bufferline")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			-- TODO: Put into file
			require("ibl").setup()
		end,
	},
	{
		"m-demare/hlargs.nvim",
		config = function()
			-- TODO: Put into file
			require("hlargs").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			-- TODO: Put into file
			require("Comment").setup()
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("core.plugin_config.nvim-tree")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {},
		config = function()
			require("core.plugin_config.gruvbox")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		},
		config = function()
			require("core.plugin_config.lualine")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				python = { "pylint" },
				lua = { "luacheck" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			require("core.plugin_config.codeium")
		end,
	},
	{
		"stevearc/conform.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function()
			require("core.plugin_config.conform")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("core.plugin_config.nvim-treesitter")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("core.plugin_config.telescope")
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				dependencies = {},
				config = function()
					require("core.plugin_config.mason-tool-installer")
				end,
			},
			{
				-- Completion framework:
				"hrsh7th/nvim-cmp",
				dependencies = {
					-- LSP completion source:
					"hrsh7th/cmp-nvim-lsp",
					-- Useful completion sources:
					"hrsh7th/cmp-nvim-lua",
					"hrsh7th/cmp-nvim-lsp-signature-help",
					"hrsh7th/cmp-vsnip",
					"hrsh7th/cmp-path",
					-- "hrsh7th/cmp-cmdline",
					"hrsh7th/cmp-buffer",
					"hrsh7th/vim-vsnip",
					-- Useful completion snippets
					"L3MON4D3/LuaSnip",
					"saadparwaiz1/cmp_luasnip",
					"rafamadriz/friendly-snippets",
				},
				config = function()
					require("core.plugin_config.auto_completion_general")
				end,
			},
		},
		config = function()
			require("core.plugin_config.lsp_general")
		end,
	},
})
-- END Lazy plugin manager
