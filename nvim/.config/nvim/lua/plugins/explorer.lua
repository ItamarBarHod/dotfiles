local function set_git_highlights()
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#e0af68", bold = true }) -- yellow
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusAdded",     { fg = "#9ece6a", bold = true }) -- green
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified",  { fg = "#e0af68", bold = true }) -- yellow
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusDeleted",   { fg = "#f7768e", bold = true }) -- red
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusRenamed",   { fg = "#e0af68", bold = true }) -- yellow
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusStaged",    { fg = "#9ece6a", bold = true }) -- green
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored",   { fg = "#565f89" })               -- dim
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUnmerged",  { fg = "#f7768e", bold = true }) -- red
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_git_highlights })
set_git_highlights()

return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = true,
    },
    picker = {
      icons = {
        git = {
          enabled   = true,
          staged    = "✓",
          added     = "+",
          deleted   = "✗",
          modified  = "●",
          renamed   = "➜",
          untracked = "?",
          unmerged  = "",
          ignored   = "◌",
        },
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          follow_file = true,
          auto_close = false,
          jump = { close = false },
          git_status = true,
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
