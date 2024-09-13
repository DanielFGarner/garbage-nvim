-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

require'lspconfig'.pyright.setup{}

local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "ts_ls", "clangd" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = configs.on_attach,
    on_init = configs.on_init,
    capabilities = configs.capabilities,
  }
end

lspconfig.pyright.setup {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  filetypes = { "python" }
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = configs.on_attach,
--   on_init = configs.on_init,
--   capabilities = configs.capabilities,
-- }

