return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- Disable all <leader>c mappings
            { "<leader>ca", false },
            { "<leader>cA", false },
            { "<leader>cr", false },
            { "<leader>cl", false },
            { "<leader>cR", false },
            { "<leader>cc", false },
            { "<leader>cC", false },
            -- Remap to <leader>l
            { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            {
              "<leader>lA",
              function()
                vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
              end,
              desc = "Source Action",
              has = "codeAction",
            },
            {
              "<leader>lr",
              function()
                local inc_rename = require("inc_rename")
                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
              end,
              expr = true,
              desc = "Rename (inc-rename.nvim)",
              has = "rename",
            },
            { "<leader>ll", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
            { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
            { "<leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
            {
              "<leader>lR",
              function()
                Snacks.rename.rename_file()
              end,
              desc = "Rename File",
              mode = { "n" },
              has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        jsonc = { "prettier" },
      },
    },
    keys = {
      { "<leader>cf", false },
      { "<leader>cF", false },
      { "<leader>lf", function() LazyVim.format({ force = true }) end, desc = "Format", mode = { "n", "v" } },
      { "<leader>lF", function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end, desc = "Format Injected", mode = { "n", "v" } },
    },
  },

  {
    "mason-org/mason.nvim",
    keys = {
      { "<leader>cm", false },
    },
  },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>cs", false },
      { "<leader>cS", false },
      { "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>lS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
    },
  },
}
