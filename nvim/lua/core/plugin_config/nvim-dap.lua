-- nvim-dap is a Debug Adapter Protocol client implementation for Neovim. nvim-dap allows you to: Launch an application to debug, Attach to running applications and debug them, Set breakpoints and step through code, Inspect the state of the application
require("dapui").setup()
local dap = require("dap")
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
	dapui.close()
end
vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DatStepOver<CR>")
