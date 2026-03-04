return {
  { "akinsho/bufferline.nvim", enabled = false },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",
      spec = {
        { "<leader>l", group = "language" },
        { "<leader>p", group = "packages" },
        { "<leader>c", hidden = true },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      diagnostics = {
        virtual_text = false,
        virtual_lines = true,
      },
    },
  },
}
