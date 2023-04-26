local M = {
  settings = {
    vetur = {
      completion = {
        autoImport = true,
        useScaffoldSnippets = true,
      },
      format = {
        defaultFormatter = {
          html = "none",
          js = "prettier",
          ts = "prettier",
        },
      },
      validation = {
        template = true,
        script = true,
        style = true,
        templateProps = true,
        interpolation = true,
      },
      experimental = {
        templateInterpolationService = true,
      },
    },
  },
}

return M
