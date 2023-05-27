return {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      },
      inlayHints = {
        parameterHints = true,
        bindingModeHints = {
          enable = true
        },
        closureReturnTypeHints = {
          enable = true
        },
        lifetimeElisionHints = {
          enable = true
        }
      }
    }
  }
}
