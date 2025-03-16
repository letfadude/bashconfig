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
          custom = {},        -- Custom filters
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,  -- Prevents "window picker" pop-up
            },
          },
        },
        git = {
          enable = true,      -- Show Git status
          ignore = false,
        },
        on_attach = function()
          local api = require("nvim-tree.api")

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- Default open behavior (Enter key)
          vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))

          -- Open in new tab
          vim.keymap.set("n", "t", api.node.open.tab, opts("Open in New Tab"))

          -- Open in new tab without closing tree
          vim.keymap.set("n", "T", function()
            api.node.open.tab()
            api.tree.toggle()
          end, opts("Open in New Tab & Close Tree"))
        end,
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
  },
  {
    "github/copilot.vim",
    lazy = false, 
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}  

  -- Add more plugins here
}
