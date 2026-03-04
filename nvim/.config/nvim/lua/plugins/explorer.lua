return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          prompt = " ",
          layout = {
            preview = "main",
            layout = {
              backdrop = false,
              width = 40,
              min_width = 40,
              height = 0,
              position = "left",
              border = "none",
              box = "vertical",
              { win = "input", height = 1, border = "none", title = "" },
              { win = "list", border = "none" },
            },
          },
        },
      },
    },
  },
}
