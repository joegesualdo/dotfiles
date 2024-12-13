require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt" },
		python = { "isort", "black" },
		lua = { "stylua" },
		-- lua = { "stylua" },
		-- -- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- -- Use a sub-list to run only the first available formatter
		-- javascript = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 2000,
		lsp_fallback = true,
	},
})
