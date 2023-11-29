local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

-- The path in windows is different
if this_os:find("Windows") then
	codelldb_path = extension_path .. "adapter\\codelldb.exe"
	liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
else
	-- The liblldb extension is .so for linux and .dylib for macOS
	liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

vim.print(codelldb_path)
local adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

require("rust-tools").setup({
	dap = {
		adapter = adapter,
	},
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set(
				"n",
				"<Leader>a",
				require("rust-tools").code_action_group.code_action_group,
				{ buffer = bufnr }
			)
		end,
	},
	tools = {
		hover_actions = {
			auto_focus = true,
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},
		},
	},
})
-- require("rust-tools").setup({
-- 	--server = {
-- 	--	on_attach = function(_, bufnr)
-- 	--		-- Hover actions
-- 	--		vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
-- 	--		-- Code action groups
-- 	--		vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
-- 	--	end,
-- 	--},
-- })
