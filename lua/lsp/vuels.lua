local M = {
  settings = {
    vetur = {
      ignoreProjectWarning = false,
      useWorkspaceDependencies = false,
      completion = {
        autoImport = true,
        useScaffoldSnippets = true,
        scaffoldSnippetSources = {
            workspace = "💼",
            user = "🗒️",
            vetur = "✌"
        },
        tagCasing = "kebad"
      },
      grammar = {
        customBlocks = {
          docs = "md",
            i18n = "json"
        }
      },
      format = {
        enable = true,
        options = {
          tabSize = 2,
          useTabs = false,
        },
        defaultFormatter = {
          html = "prettier",
          js = "prettier",
          ts = "prettier",
          css = "prettier",
          postcss = "prettier",
          scss = "prettier",
          sass = "prettier",
        },
      },
      validation = {
        template = true,
        script = true,
        style = true,
        templateProps = false,
        interpolation = true,
      },
      languageFeatures = {
        updateImportOnFileMove = true,
      },
      trace = {
        server = "off",
      },
      dev = {
        vlsPort = -1,
        logLevel = "INFO"
      },
      experimental = {
        templateInterpolationService = false,
      },
      underline = {
        refValue = true
      }
    },
  },
}

return M
