return {
    settings = {
        pylsp = {
            plugins = {
                ruff = {
                    enabled = true,
                    ignore = { "E501" },
                },
                pycodestyle = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                },
                mccabe = {
                    enabled = false,
                },
            },
        },
    },
}
