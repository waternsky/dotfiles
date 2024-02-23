local function autosave()
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("custom_command", { clear = true }),
        pattern = "*.rs",
        callback = function()
            local filePath = vim.api.nvim_buf_get_name(0)
            vim.cmd("!rustfmt " .. filePath)
        end,
    })
end

vim.api.nvim_create_user_command("Format", function()
    autosave()
end, {})
