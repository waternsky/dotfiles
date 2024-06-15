return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    config = function ()
        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            view_options = { show_hidden = true },
        })
        vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
        vim.keymap.set("n", "<leader>e", vim.cmd.Oil)
    end,
}
