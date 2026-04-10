return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Lsp manger
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- auto completion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",

        -- snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        -- notifications
        "j-hui/fidget.nvim",
    },
    config = function()
        require("fidget").setup({})
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "ts_ls",
                "clangd",
                "tailwindcss",
            },
        })

        -- mason-lspconfig calls this good practice (incase you uninstall mason)
        vim.lsp.enable({
            "lua_ls",
            "clangd",
            "zls",
            "mojo",
            "ocamllsp",
            "pylsp",
            "ts_ls",
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered({ border = "bold" }),
                documentation = cmp.config.window.bordered({ border = "bold" }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        })

        vim.diagnostic.config({
            virtual_lines = { current_line = true },
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "bold",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kush", {}),
            callback = function(args)
                local opts = { buffer = args.buf }
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
                vim.keymap.set("n", "gr", builtin.lsp_references, opts)

                vim.keymap.set("n", "gl", vim.diagnostic.setloclist, opts)
                vim.keymap.set("n", "gk", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.jump({ count = -1 })
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.jump({ count = 1 })
                end, opts)

                vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover({ border = "bold" })
                end, opts)
                vim.keymap.set("i", "<C-k>", function()
                    vim.lsp.buf.signature_help({ border = "bold" })
                end, opts)

                vim.api.nvim_buf_create_user_command(args.buf, "Format", function()
                    vim.lsp.buf.format()
                end, {})
            end,
        })
    end,
}
