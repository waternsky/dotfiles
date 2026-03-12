return {
    filetypes = { "c", "cpp", "cuda" },
    cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
    -- init_options = {
    --     fallbackFlags = { "-std=c++17" },
    -- },
}
