-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 如果是 fcitx5 或 ibus，按了 ESC 后自动切回英文输入法
local input_method_group = vim.api.nvim_create_augroup("user_input_method", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = input_method_group,
  desc = "Switch to English input method when leaving insert mode",
  callback = function()
    if vim.fn.executable("fcitx5-remote") == 1 then
      vim.fn.jobstart({ "fcitx5-remote", "-c" }, { detach = true })
    elseif vim.fn.executable("ibus") == 1 then
      vim.fn.jobstart({ "ibus", "engine", "xkb:us::eng" }, { detach = true })
    end
  end,
})
