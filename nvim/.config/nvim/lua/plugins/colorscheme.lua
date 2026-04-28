return {

  -- Configure LazyVim theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
      -- colorscheme = "ayu-mirage",
    },
  },

  -- add theme
  { "ellisonleao/gruvbox.nvim" },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    config = function()
      require("ayu").setup({
        -- mirage = false, -- true = 使用 ayu-mirage
        terminal = true,
      })
    end,
  },

  -- configure catppuccin-nvim
  {
    "catppuccin/nvim",
    opts = {
      integrations = {
        snacks = {
          -- 可改成 blue / mauve / pink 等
          indent_scope_color = "pink",
        },
      },
    },
  },
}
