-- Speeds up NeoVim?
vim.loader.enable()

-- vim shares clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.paste = false

-- Disables the creation of swap files
vim.opt.swapfile = false

-- Change the icons near error, warning, etc
-- Option 1: Using the function approach
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ""
    })
end

sign({ name = "DiagnosticSignError", text = "x" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "~" })
sign({ name = "DiagnosticSignInfo", text = "i" })

-- Diagnostic configuration
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

