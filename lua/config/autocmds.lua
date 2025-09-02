-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
-- local forge_fmt_group = vim.api.nvim_create_augroup("autocmds for forge", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   pattern = { "*.sol" },
--   desc = "Auto-format solidity files after saving",
--   callback = function()
--     vim.cmd("silent! !forge fmt")
--   end,
--   group = forge_fmt_group,
-- })

local forge_fmt_group = vim.api.nvim_create_augroup("autocmds for forge", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.sol" },
  desc = "Auto-format solidity files after saving",
  callback = function()
    vim.cmd("silent! !forge fmt")
  end,
  group = forge_fmt_group,
})

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  pattern = "*.sol",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local text = table.concat(content, "\n")

    local job = vim.fn.jobstart({ "forge", "fmt", "--raw", "-" }, {
      stdout_buffered = true,
      stderr_buffered = true,
      stdin_buffered = true,
      on_stdout = function(_, data)
        if data and data[1] ~= "" then
          -- Prevent triggering autocommands
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, data)
          -- Set the buffer as unmodified
          vim.bo[bufnr].modified = false
        end
      end,
    })

    vim.fn.chansend(job, text)
    vim.fn.chanclose(job, "stdin")
  end,
})
