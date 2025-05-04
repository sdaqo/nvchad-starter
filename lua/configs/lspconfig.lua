require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html", "cssls", "ts_ls", "clangd",
  "pyright", "intelephense", "yamlls",
  "nil_ls", "gopls"
}

vim.lsp.config.omnisharp.cmd = { "omnisharp-mono" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
