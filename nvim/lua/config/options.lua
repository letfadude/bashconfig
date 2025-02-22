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

