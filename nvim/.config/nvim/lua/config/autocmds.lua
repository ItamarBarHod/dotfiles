-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Disable LSP diagnostics in scratch buffers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = vim.fn.stdpath("data") .. "/scratch/*",
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 })
  end,
})
