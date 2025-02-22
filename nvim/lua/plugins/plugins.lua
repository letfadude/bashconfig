return {
  -- Catppuccin Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
        }
      })
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- For file icons
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,         -- Set the width of the file explorer
          side = "left",      -- Open on the left side
          number = false,     -- Disable line numbers in the tree
          relativenumber = false,
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,   -- Show hidden files
        },
        git = {
          enable = true,      -- Show Git status
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
	require'lspconfig'.golangci_lint_ls.setup{}
	require'lspconfig'.gopls.setup{}
	require'lspconfig'.clangd.setup{}
	require'lspconfig'.pyright.setup{}
    end
  },
  {"hrsh7th/nvim-cmp"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  {"L3MON4D3/LuaSnip"},
  {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup {}
  end
  }
  

  -- Add more plugins here
}
