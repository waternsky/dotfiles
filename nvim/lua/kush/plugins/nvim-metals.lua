return {
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt", "java" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "j-hui/fidget.nvim",
                opts = {},
            },
        },
        keys = {
            { "<leader>cW", function() require('metals').hover_worksheet() end,               desc = "Metals Worksheet" },
            { "<leader>cM", function() require('telescope').extensions.metals.commands() end, desc = "Telescope Metals Commands" },
        },
        opts = function()
            local metals_config = require("metals").bare_config()

            metals_config.settings = {
                showImplicitArguments = true,
                showImplicitConversionsAndClasses = true,
                showInferredType = true,
                superMethodLensesEnabled = true,
            }
            metals_config.init_options.statusBarProvider = "off"
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
}
