return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
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
