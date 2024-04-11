return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.g.loaded_netrw = 1 -- disabling netrw
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup({})
        vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer" })
    end,
}
