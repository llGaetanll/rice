return {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
      },
      imports = {
        granularity = { group = "item" },
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
      rustfmt = {
        overrideCommand = { "rustfmt", "+nightly" },
        extraArgs = { "--check", "--unstable-features" }
      }
    },
  },
}
