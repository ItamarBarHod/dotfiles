return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>nY",
        function()
          local history = require("snacks").notifier.get_history()
          local lines = {}
          for _, notif in ipairs(history) do
            table.insert(lines, string.format("[%s] %s", notif.level, notif.msg))
          end
          vim.fn.setreg("+", table.concat(lines, "\n"))
          vim.notify("Yanked " .. #lines .. " notifications to clipboard")
        end,
        desc = "Yank Notification History",
      },
      {
        "<leader>nh",
        function()
          local history = require("snacks").notifier.get_history()
          local lines = {}
          for _, notif in ipairs(history) do
            table.insert(lines, string.format("[%s] %s", notif.level, notif.msg))
          end
          vim.cmd("enew")
          vim.bo.buftype = "nofile"
          vim.bo.bufhidden = "wipe"
          vim.bo.filetype = "log"
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
          vim.bo.modifiable = false
        end,
        desc = "Notification History Buffer",
      },
    },
  },
}
