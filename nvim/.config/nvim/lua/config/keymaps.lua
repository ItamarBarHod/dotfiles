local map = vim.keymap.set

map("n", "<leader>pm", "<cmd>Lazy<cr>", { desc = "Lazy (Package Manager)" })
map("n", "<leader>pl", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
map("n", "<leader>pn", "<cmd>Mason<cr>", { desc = "Mason" })

map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>lD", function() Snacks.picker.diagnostics() end, { desc = "Workspace Diagnostics" })

map("n", "<leader>j", function() Snacks.scratch({ ft = "json", name = "JSON" }) end, { desc = "JSON Scratch" })

vim.keymap.del("n", "<leader>l")
vim.keymap.del({ "n", "x" }, "<leader>cf")
vim.keymap.del("n", "<leader>cd")
