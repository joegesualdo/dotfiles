require("mason").setup()
local on_attach = function(_)
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, {})
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {})
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
	-- vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_reference, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end
-- DO I NEED THIS?
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "basedpyright", "rust_analyzer" },
	automatic_installation = false,
	-- on_attach = on_attach,
	handlers = {
		function(server_name) -- default handler (optional)
			on_attach(server_name)
		end,
	},
})
require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			diagnostics = {
				enable = true,
			},
		},
	},
})
require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
				},
			},
		},
	},
})
require("lspconfig").basedpyright.setup({})
-- require('lspconfig').lua_ls.setup()
-- require("lspconfig").pyright.setup({
-- 	capabilities = capabilities,
-- })
