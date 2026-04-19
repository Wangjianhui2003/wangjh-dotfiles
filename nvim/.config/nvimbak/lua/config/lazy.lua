-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local plugins = {
      spec = {
        { import = 'plugins' },
      },
}
local opts = {}

require("lazy").setup(plugins, opts)

if #vim.api.nvim_get_runtime_file("parser/lua.*", true) == 0 then
  for _, path in ipairs({ "/usr/lib/nvim", "/usr/lib64/nvim" }) do
    if vim.fn.isdirectory(path .. "/parser") == 1 and not vim.tbl_contains(vim.opt.rtp:get(), path) then
      vim.opt.rtp:append(path)
      break
    end
  end
end
