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
		"stevearc/oil.nvim",
		-- File management, similar to netrw. Lightweight.
		opts = {},
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- Adds file type icons. Lightweight.
		},
		config = function()
			require("core.plugin_config.oil")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- Adds indentation guides to all lines. Lightweight. 🍃
		main = "ibl",
		opts = {},
		event = "BufReadPre",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"m-demare/hlargs.nvim",
		-- Highlights arguments' definitions and usages. Lightweight. 🍃
		event = "BufReadPre",
		config = function()
			require("hlargs").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		-- Easy commenting. Lightweight. 🍃
		event = "BufReadPre",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		-- Adds file type icons. Lightweight. 🍃
		event = "BufReadPre",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		-- Automatically close pairs like brackets and quotes. Lightweight. 🍃
		event = "InsertEnter",
		opts = {},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		-- File explorer tree. Can be heavy depending on usage. 🏋️
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Common utilities. Lightweight.
			"nvim-tree/nvim-web-devicons", -- Adds file type icons. Lightweight.
			"MunifTanjim/nui.nvim", -- UI components. Lightweight.
		},
		config = function()
			require("core.plugin_config.nvim-tree")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		-- Gruvbox color scheme. Lightweight. 🍃
		priority = 1000,
		opts = {},
		config = function()
			require("core.plugin_config.gruvbox")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		-- Status line plugin. Lightweight. 🍃
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- Adds file type icons. Lightweight.
		},
		event = "BufReadPre",
		config = function()
			require("core.plugin_config.lualine")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		-- Linting for various languages. Can be heavy depending on the linter. 🏋️
		event = "BufReadPre",
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
		-- AI code completion. Can be heavy. 🏋️
		event = "BufEnter",
		config = function()
			require("core.plugin_config.codeium")
		end,
	},
	{
		"stevearc/conform.nvim",
		-- Code formatting. Can be heavy depending on the formatter. 🏋️
		event = "BufReadPre",
		opts = {},
		config = function()
			require("core.plugin_config.conform")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		-- Syntax highlighting and more. Can be heavy. 🏋️
		build = ":TSUpdate",
		event = "BufReadPre",
		config = function()
			require("core.plugin_config.nvim-treesitter")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- Fuzzy finder and more. Can be heavy. 🏋️
		dependencies = {
			"nvim-lua/plenary.nvim", -- Common utilities. Lightweight.
		},
		config = function()
			require("core.plugin_config.telescope")
		end,
	},
	{
		"williamboman/mason.nvim",
		-- LSP and completion setup. Can be heavy. 🏋️
		dependencies = {
			"williamboman/mason-lspconfig.nvim", -- Bridges mason.nvim with lspconfig. Lightweight.
			"neovim/nvim-lspconfig", -- Quickstart configurations for the Nvim LSP client. Lightweight.
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				-- Automatically install LSP servers, DAP servers, linters, and formatters. Lightweight.
				dependencies = {},
				config = function()
					require("core.plugin_config.mason-tool-installer")
				end,
			},
			{
				"hrsh7th/nvim-cmp",
				-- Completion framework. Can be heavy. 🏋️
				dependencies = {
					"hrsh7th/cmp-nvim-lsp", -- LSP completion source. Lightweight.
					"hrsh7th/cmp-nvim-lua", -- Lua completion source. Lightweight.
					"hrsh7th/cmp-nvim-lsp-signature-help", -- Signature help completion source. Lightweight.
					-- "hrsh7th/cmp-vsnip", -- Snippet completion source. Lightweight.
					"hrsh7th/cmp-path", -- Path completion source. Lightweight.
					"hrsh7th/cmp-buffer", -- Buffer completion source. Lightweight.
					"hrsh7th/vim-vsnip", -- Snippet engine. Lightweight.
					"L3MON4D3/LuaSnip", -- Snippet engine. Lightweight.
					"saadparwaiz1/cmp_luasnip", -- LuaSnip completion source. Lightweight.
					"rafamadriz/friendly-snippets", -- Preconfigured snippets. Lightweight.
				},
				event = "InsertEnter",
				config = function()
					require("core.plugin_config.auto_completion_general")
				end,
			},
		},
		config = function()
			require("core.plugin_config.lsp_general")
		end,
	},
	{
		"yetone/avante.nvim",
		-- Avante plugin for enhanced functionality. Can be heavy due to Rust compilation. 🏋️
		event = "VeryLazy",
		lazy = false,
		opts = {
			provider = "claude",
		},
		build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		dependencies = {
			"stevearc/dressing.nvim", -- Improved UI components. Lightweight.
			"nvim-lua/plenary.nvim", -- Common utilities. Lightweight.
			"MunifTanjim/nui.nvim", -- UI components. Lightweight.
			"nvim-tree/nvim-web-devicons", -- Adds file type icons. Lightweight.
			"zbirenbaum/copilot.lua", -- AI code completion. Can be heavy.
			{
				"HakonHarnes/img-clip.nvim",
				-- Support for image pasting. Lightweight.
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				-- Render markdown files. Lightweight.
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
})
-- END Lazy plugin manager
