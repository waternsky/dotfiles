vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("soydev", { clear = true }),
    pattern = { "*.jsx", "*.tsx", "*.html", "*.ml", "*.js", "*.ts", "*.c", "*.cpp" },
    command = "set autoindent expandtab tabstop=2 shiftwidth=2",
})
