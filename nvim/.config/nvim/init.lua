-- 1. 基础选项 (Options)
local opt = vim.opt

-- 行号配置
opt.number = true          -- 显示绝对行号
-- opt.relativenumber = true  -- 显示相对行号 (方便跳转)

-- 缩进与Tab
opt.tabstop = 4            -- Tab 键占据的空格数
opt.shiftwidth = 4         -- 自动缩进时的宽度
opt.expandtab = true       -- 将 Tab 自动转换为空格
opt.autoindent = true      -- 换行时自动对齐上一行


-- 外观
opt.cursorline = true      -- 高亮当前行
