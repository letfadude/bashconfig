-- TAB STYLE
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")


-- LINE NUMBERS
vim.opt.number = true
vim.opt.relativenumber = true

--TABS
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- CLIPBOARD 
vim.g.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline",
  },
  cache_enabled = 0,
}
vim.keymap.set("v", "Y", '"+y')

-- EXIT TERMINAL WITH ESC
vim.keymap.set("t","<Esc>","<C-\\><C-n>",{noremap = true, silent = true})

-- MV SELECTION UP/DOWN
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- USE TELESCOPE TO FIND DEFINITION
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })

-- OPEN TELESCOPE FIND FILES
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    hidden = true,
    follow = true,
  })
  -- FIND IN FILES (GREP)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", function()
  builtin.live_grep({
    hidden = true,
  })
end, { noremap = true, silent = true })

vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- MONOKAI SETUP
require("monokai-pro").setup({
  transparent_background = false,
  terminal_colors = true,
  devicons = true,
  styles = {
    comment = { italic = true },
    keyword = { italic = true },
    type = { italic = true },
    storageclass = { italic = true },
    structure = { italic = true },
    parameter = { italic = true },
    annotation = { italic = true },
    tag_attribute = { italic = true },
  },
  filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
  day_night = {
    enable = false,
    day_filter = "pro",
    night_filter = "spectrum",
  },
  inc_search = "background", -- underline | background
  background_clear = {
    "toggleterm",
    "telescope",
    "renamer",
    "notify",
  },
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
      underline_fill = false,
      bold = true,
    },
    indent_blankline = {
      context_highlight = "default", -- default | pro
      context_start_underline = false,
    },
  },
  override = function(scheme)
    return {}
  end,
  override_palette = function(filter)
    return {}
  end,
  override_scheme = function(scheme, palette, colors)
    return {}
  end,
})







