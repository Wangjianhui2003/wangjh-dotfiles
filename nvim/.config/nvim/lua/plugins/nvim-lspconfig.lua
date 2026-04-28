return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = true,
    },
    codelens = {
      enabled = false, -- 目前有bug
    },
  },
}
