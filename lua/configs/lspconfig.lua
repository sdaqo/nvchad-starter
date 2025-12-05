local servers = {
  html = {},
  cssls = {},
  ts_ls = {},
  clangd = {},
  bashls = {},
  nil_ls = {},
  gopls = {},
  intelephense = {},
  yamlls = {},

  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
