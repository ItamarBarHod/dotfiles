local function set_git_highlights()
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#e0af68" }) -- yellow
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusAdded",     { fg = "#9ece6a" }) -- green
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified",  { fg = "#e0af68" }) -- yellow
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusDeleted",   { fg = "#f7768e" }) -- red
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusRenamed",   { fg = "#e0af68" }) -- yellow
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusStaged",    { fg = "#9ece6a" }) -- green
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored",   { fg = "#565f89" }) -- dim
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUnmerged",  { fg = "#f7768e" }) -- red
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_git_highlights })
set_git_highlights()

-- Refresh snacks explorer git status when returning focus to nvim
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    local ok, snacks = pcall(require, "snacks")
    if ok and snacks.picker then
      for _, p in ipairs(snacks.picker.get({ source = "explorer" }) or {}) do
        p:find({ refresh = true })
      end
    end
  end,
})

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
