return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            diagnostics = {
                enable = true,
            },
            inlayHints = {
                parameterHints = true,
                bindingModeHints = {
                    enable = true,
                },
                closureReturnTypeHints = {
                    enable = true,
                },
                lifetimeElisionHints = {
                    enable = true,
                },
            },
        },
    },
}
