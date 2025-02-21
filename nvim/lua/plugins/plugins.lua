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

  

  -- Add more plugins here
}
