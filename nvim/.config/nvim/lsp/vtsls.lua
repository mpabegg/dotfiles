return {
  settings = {
    vtsls = {
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = 'all' },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = 'all' },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
  init_options = {
    publishDiagnostics = true,
  },
  on_new_config = function(new_config, _)
    -- Explicitly disable formatting for vtsls
    new_config.capabilities = new_config.capabilities or {}
    new_config.capabilities.documentFormattingProvider = false
    new_config.capabilities.documentRangeFormattingProvider = false
  end,
}
