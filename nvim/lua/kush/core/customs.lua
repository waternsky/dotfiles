vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("soydev", {}),
    pattern = { "*.jsx", "*.tsx", ".html" },
    command = "set autoindent expandtab tabstop=2 shiftwidth=2"
})
