local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Shared on_attach function (buffer-local keymaps, formatting, etc.)
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP keymaps
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

  -- Autoformat on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

-- Register LSP servers
local servers = {
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        analyses = { unusedparams = true },
        completeUnimported = true,
        usePlaceholders = true,
        staticcheck = true,
      },
    },
  },
  pyright = {},
  clangd = {},
  golangci_lint_ls = {},
  lua_ls = {},
}

for server, config in pairs(servers) do
  vim.lsp.config[server] = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
  }, config)
  vim.lsp.enable(server)
end

-- Setup nvim-cmp
cmp.setup({
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

