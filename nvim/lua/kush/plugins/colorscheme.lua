return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
            })
            vim.cmd([[colorscheme tokyonight]])
            -- vim.cmd([[hi LineNr guifg=#37dd21]])
            -- vim.cmd([[hi CursorLineNr guifg=#cdd6f4]])
            -- vim.cmd([[hi LineNrAbove guifg=#eba0ac]])
            -- vim.cmd([[hi LineNrBelow guifg=#94e2d5]])
            -- vim.cmd([[hi Status_LineNr guifg=#6c7086]])
            -- vim.cmd([[hi Status_DivLine guibg=#1e1e2e guifg=#313244]])
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                term_colors = true,
                transparent_background = true,
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                color_overrides = {
                    mocha = {
                        rosewater = "#ffc9c9",
                        flamingo = "#ff9f9a",
                        pink = "#ffa9c9",
                        mauve = "#df95cf",
                        lavender = "#a990c9",
                        red = "#ff6960",
                        maroon = "#f98080",
                        peach = "#f9905f",
                        yellow = "#f9bd69",
                        green = "#b0d080",
                        teal = "#a0dfa0",
                        sky = "#a0d0c0",
                        sapphire = "#95b9d0",
                        blue = "#89a0e0",
                        text = "#e0d0b0",
                        subtext1 = "#d5c4a1",
                        subtext0 = "#bdae93",
                        overlay2 = "#928374",
                        overlay1 = "#7c6f64",
                        overlay0 = "#665c54",
                        surface2 = "#504844",
                        surface1 = "#3a3634",
                        surface0 = "#252525",
                        base = "#151515",
                        mantle = "#0e0e0e",
                        crust = "#080808",
                    },
                },
                integrations = {
                    cmp = true,
                    nvimtree = true,
                    treesitter = true,
                    telescope = {
                        enabled = true,
                    },
                },
            })
            -- vim.cmd([[colorscheme catppuccin-mocha]])
            vim.cmd([[hi LineNr guifg=#766f64]]) -- I didn't like LineNr color, so i changed it
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                },
            })
            -- vim.cmd([[colorscheme carbonfox]])
        end,
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd([[colorscheme moonfly]])
        end,
    },
    {
        "tiagovla/tokyodark.nvim",
        config = function()
            require("tokyodark").setup({
                transparent_background = false,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    identifiers = { italic = false },
                    functions = {},
                    variables = {},
                },
            })
            -- vim.cmd([[colorscheme tokyodark]])
        end,
    },
}
