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
          defaultFormatter = {
            js = "prettier",
            ts = "prettier"
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false
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
