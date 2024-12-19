local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    nix = { "alejandra" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
