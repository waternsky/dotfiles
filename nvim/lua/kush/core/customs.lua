vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("soydev", { clear = true }),
    pattern = { "*.jsx", "*.tsx", "*.html", "*.ml", "*.js", "*.ts", "*.c", "*.cpp", "*.h" },
    command = "set autoindent expandtab tabstop=2 shiftwidth=2",
})

-- vyper-lsp setup

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.vy" },
    callback = function()
        vim.lsp.start({
            name = "vyper-lsp",
            cmd = { "vyper-lsp" },
            root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
        })
    end,
})
