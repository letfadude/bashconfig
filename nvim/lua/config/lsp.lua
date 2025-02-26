local lspconfig = require('lspconfig')
local cmp = require('cmp')

-- Setup gopls
lspconfig.gopls.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
	    print("gopls attached to buffer: " .. bufnr)
	    -- Enable autoformat on save
	    vim.api.nvim_create_autocmd("BufWritePre", {
	      buffer = bufnr,
	      callback = function()
		print("fmt running!")
		vim.lsp.buf.format({ async = false })
	      end,
	    })
	end,
	settings = {
		gopls = {
			
			gofumpt = true,
			analyses = {
				unusedparams = true,
			},
			completeUnimported = true,
			usePlaceholders = true,
			staticcheck = true,
		},
}}

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
