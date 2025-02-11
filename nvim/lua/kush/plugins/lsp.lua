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

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "ts_ls",
                "clangd",
                "tailwindcss",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = {
                                    globals = { "vim", "describe", "it", "before_each", "after_each" },
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                workspace = { checkThirdParty = false },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,

                ["pylsp"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pylsp.setup({
                        settings = {
                            pylsp = {
                                plugins = {
                                    ruff = {
                                        enabled = true,
                                    },
                                    pycodestyle = {
                                        enabled = false,
                                        ignore = { "E501" },
                                    },
                                },
                            },
                        },
                    })
                end,

                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup({
                        cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
                        init_options = {
                            fallbackFlags = { "-std=c++17" },
                        },
                    })
                end,

                ["ts_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ts_ls.setup({
                        settings = {
                            implicitProjectConfiguration = {
                                checkJs = true,
                            },
                        },
                    })
                end,
            },
        })

        local lspconfig = require("lspconfig")
        lspconfig.mojo.setup({
            capabilities = capabilities,
            cmd = { "/Users/kush/.modular/bin/mojo-lsp-server" },
        })

        lspconfig.ocamllsp.setup({
            capabilities = capabilities,
            cmd = { "/Users/kush/.opam/default/bin/ocamllsp" },
        })

        lspconfig.zls.setup({
            capabilities = capabilities,
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
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
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
            virtual_text = true,
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
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
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

                vim.api.nvim_buf_create_user_command(args.buf, "Format", function()
                    vim.lsp.buf.format()
                end, {})
            end,
        })
    end,
}
