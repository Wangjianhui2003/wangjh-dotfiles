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

-- 按ESC后切换输入法
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

-- ================================================================================ spell check

-- 关闭markdown等的拼写检查
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- 开启en检查，cjk:避免中文、日文、韩文被当成拼写错误
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "markdown", "text", "gitcommit" },
--   callback = function()
--     vim.opt_local.spell = true
--     vim.opt_local.spelllang = { "en", "cjk" }
--   end,
-- })

-- en     = generic English / 通用英语
-- en_us  美式英语
-- en_gb  英式英语
-- fr     法语
-- es     西班牙语
-- de     德语
-- it     意大利语
-- pt     葡萄牙语
-- ru     俄语
-- cjk    中文/日文/韩文字符不参与拼写报错

-- 检查拼写
-- :setlocal spell?
-- :setlocal spelllang?

-- :set spelllang=en_us,cjk

-- vim.opt.spelllang        = 设置当前环境，类似 :set
-- vim.opt_global.spelllang = 设置全局默认值，类似 :setglobal
-- vim.opt_local.spelllang  = 只设置当前 buffer，类似 :setlocal

-- 全局开启检查,放到 options.lua
-- vim.opt.spelllang = { "en_us", "cjk" }
-- vim.opt.spell = true
