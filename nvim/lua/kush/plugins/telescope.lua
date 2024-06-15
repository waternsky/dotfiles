return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.6",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function ()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules", "dist", ".git", ".next",
                },
            },
        })

        local builtin = require("telescope.builtin")

        -- below command for getting .env, .env.example files, .. etc. file_ignore_patterns above necessary
        vim.keymap.set("n", "<leader>ff", ":Telescope find_files hidden=true find_command=rg,--hidden,--files,-u<CR>", { desc = "[F]ind [F]iles" })
        vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind in [G]it tracked files" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind opened [B]uffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp / man pages" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecently opened files" })
        vim.keymap.set("n", "<leader>fw", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "[F]ind current [W]ord" })

        require("telescope").load_extension("fzf")
    end
}
