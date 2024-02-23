return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dockerfile",
                "go",
                "html",
                "jsdoc",
                "lua",
                "ocaml",
                "python",
                "rust",
                "sql",
                "typescript",
                "javascript",
                "tsx"
            },
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                },
            },
        })
    end,
}
