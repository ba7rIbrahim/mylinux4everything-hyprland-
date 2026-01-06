-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- Fixed Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })

-- Auto Save Toggle
vim.keymap.set("n", "<leader>as", function()
  if vim.g.auto_save_enabled == true then
    vim.g.auto_save_enabled = false
    print("Auto-Save: OFF")
  else
    vim.g.auto_save_enabled = true
    print("Auto-Save: ON")
  end
end, { desc = "Toggle Auto-Save" })

-- Manual Save
vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save File" })

-- Manual Format
vim.keymap.set("n", "<leader>fm", function()
  LazyVim.format({ force = true })
end, { desc = "Format Document (Manual)" })
