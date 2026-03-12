return {
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
}
