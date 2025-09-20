vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")


vim.opt.number = true
vim.opt.relativenumber = true
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.g.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "xsel",
  copy = {
    ["+"] = "xsel --clipboard --input",
    ["*"] = "xsel --clipboard --input",
  },
  paste = {
    ["+"] = "xsel --clipboard --output",
    ["*"] = "xsel --clipboard --output",
  },
}
vim.keymap.set("t","<Esc>","<C-\\><C-n>",{noremap = true, silent = true})

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    hidden = true,
    follow = true,
  })
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", function()
  builtin.live_grep({
    hidden = true,
  })
end, { noremap = true, silent = true })

local treeconfig = require("nvim-treesitter.configs")

treeconfig.setup({
  ensure_installed = {"lua", "go", "python", "c", "java", "javascript", "typescript", "json", "yaml", "html", "css", "bash", "rust", "toml", "dockerfile", "vim", "regex"},
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
})

vim.opt.spelllang = "en_us"
vim.opt.spell = true









