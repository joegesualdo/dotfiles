-- Speeds up NeoVim?
vim.loader.enable()

-- vim shares clipboard with system clipboard. So things you copy from outside vim can be pasted in vim using p
vim.opt.clipboard = "unnamedplus"

-- Change the icons near error, warning, etc
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end
sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })

-- END Change the icons near error, warning, etc
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
	},
})
