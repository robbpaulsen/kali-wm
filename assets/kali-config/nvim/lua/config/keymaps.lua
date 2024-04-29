-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("i", "<C-d>", function()
    local new_text = vim.fn.input("Replace with?: ")
    local cmd = "normal! *Ncgn" .. new_text
    vim.cmd(cmd)
end, { desc = "ctrl+d vs code alternative" })
