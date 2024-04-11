return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
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
            autotag = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-space>',
                    node_incremental = '<C-space>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
        })
    end,
}
