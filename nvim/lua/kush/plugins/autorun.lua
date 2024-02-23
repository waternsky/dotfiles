return {
    "waternsky/autorun",
    config = function ()
        local autorun = require("autorun")
        local opts  = {
            pythoncmd = "python3.12",
            title_pos = "center",
            border = "double",
        }
        -- autorun.setup(opts) if you want default behaviour
        autorun.Toggle(opts)
    end
}
