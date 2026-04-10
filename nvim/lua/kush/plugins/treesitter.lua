return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "<filetype>" },
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        local ensure_installed = {
            "vimdoc",
            "javascript",
            "typescript",
            "c",
            "lua",
            "rust",
            "jsdoc",
            "bash",
            "css",
            "dockerfile",
            "go",
            "html",
            "python",
            "ocaml",
            "sql",
            "tsx",
            "cpp",
        }

        local already_installed = require("nvim-treesitter").get_installed()
        local parser_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(already_installed, parser)
            end)
            :totable()
        require("nvim-treesitter").install(parser_install)
    end,
}
