local lspconfig = require('lspconfig')
local cmp = require('cmp')

-- Setup gopls
lspconfig.gopls.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- Setup nvim-cmp
cmp.setup({
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }
})
