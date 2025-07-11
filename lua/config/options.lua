-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
-- vim.g.lazyvim_python_lsp = "basedpyright"
-- vim.g.lazyvim_python_ruff = "ruff_lsp"
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
