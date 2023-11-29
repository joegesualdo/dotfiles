local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),

		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		["<C-f>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	local col = vim.fn.col(".") - 1

		-- 	if cmp.visible() then
		-- 		cmp.select_next_item(select_opts)
		-- 	elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
		-- 		fallback()
		-- 	else
		-- 		cmp.complete()
		-- 	end
		-- end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 3 }, -- from language server
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 2 }, -- source current buffer
		{ name = "path" }, -- file paths
		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
		{ name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		{ name = "calc" },
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				vsnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	-- This is how you turn it off. Comment out to turn back on.
	completion = {
		autocomplete = false,
	},
	-- Turn this off when using ai like copilot or codeium
	experimental = {
		ghost_text = false,
	},
})
