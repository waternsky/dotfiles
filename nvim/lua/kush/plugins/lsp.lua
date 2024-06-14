return {
    'neovim/nvim-lspconfig',

    dependencies = {
        -- LSP configuration
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'folke/neodev.nvim',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-vsnip',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',

        'rafamadriz/friendly-snippets',

        'nvim-telescope/telescope.nvim'
    },

    config = function()
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = "rounded",
                }
            )

            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                {
                    border = "rounded"
                }
            )

            vim.diagnostic.config{
                virtual_text = true,
                update_in_insert = true,
                float={
                    focusable = false,
                    style = "minimal",
                    border="rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }

            local builtin = require('telescope.builtin')

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
            nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')

            nmap('gl', vim.diagnostic.setloclist, 'Open diagnostics list')
            nmap('gk', vim.diagnostic.open_float, 'Open floating diagnostic message')
            nmap('[d', vim.diagnostic.goto_prev, 'Goto previous diagnostic message')
            nmap(']d', vim.diagnostic.goto_next, 'Goto next diagnostic message')
            nmap('<leader>T', builtin.lsp_type_definitions, '[T]ype Definition')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        local servers = {
            clangd = {},
            gopls = {},
            pyright = {},
            rust_analyzer = {},
            tsserver = {},
            html = { filetypes = { 'html', 'twig', 'hbs'} },
            tailwindcss = {},
            prismals = {},
            julials = {},
            emmet_ls = {},
            ocamllsp = {},
            lua_ls = {
                Lua = {
					runtime = {
						version = 'LuaJIT',
					},
					diagnostics = {
						globals = {
							'vim',
						},
					},
                    completion = {
                        callSnippet = "Replace"
                    },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
                force_setup = true,
            },
        }

        require('mason').setup()
        require('mason-lspconfig').setup()
        require('neodev').setup()

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end,
        }

        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'vsnip' },
                { name = 'path' },
            },
        }
    end,
}
