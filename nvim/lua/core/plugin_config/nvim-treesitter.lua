local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "javascript", "html", "python" },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
