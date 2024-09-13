require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local bar_run = require("configs.bar_run")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "\\", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "open floating term" })

map("t", "\\", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { desc = "close term in terminal mode" })


map("n", "<Bar>", function()
  bar_run:runfile(vim.fn.getreg('%'))
end, { desc = "bar run from file" })

map("t", "<Bar>", function()
  bar_run:runfile(vim.fn.getreg('#'))
end, { desc = "bar run from terminal" })
