-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
local forge_fmt_group = vim.api.nvim_create_augroup("autocmds for forge", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.sol" },
  desc = "Auto-format solidity files after saving",
  callback = function()
    vim.cmd("silent! !forge fmt")
  end,
  group = forge_fmt_group,
})
