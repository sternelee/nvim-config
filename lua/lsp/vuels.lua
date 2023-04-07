local M = {
  init_options = {
    config = {
      vetur = {
        completion = {
          autoImport = true,
          tagCasing = "kebab",
          useScaffoldSnippets = true,
        },
        format = {
          enable = true,
          options = {
            tabSize = 2
          },
          defaultFormatter = {
            html ="prettier",
            pug ="prettier",
            css ="prettier",
            js = "prettier",
            ts = "prettier",
            scss ="prettier",
            postcss ="prettier",
            sass ="prettier",
            less ="prettier",
            stylus ="prettier",
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false,
        },
        useWorkspaceDependencies = true,
        validation = {
          script = true,
          style = true,
          template = true,
        },
      },
    },
  }
}

return M;
