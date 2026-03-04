return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    opts.linters_by_ft = opts.linters_by_ft or {}
    opts.linters_by_ft["markdown"] = {}
    opts.linters_by_ft["markdown.mdx"] = {}

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.env*",
      callback = function()
        vim.diagnostic.enable(false, { bufnr = 0 })
      end,
    })
  end,
}
