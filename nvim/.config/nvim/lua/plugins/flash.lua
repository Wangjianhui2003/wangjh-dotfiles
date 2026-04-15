-- return {
--   "folke/flash.nvim",
--   opts = {
--     highlight = {
--       groups = {
--         backdrop = "FlashBackdrop",
--         match = "FlashMatch",
--         current = "FlashCurrent",
--         label = "FlashLabel",
--         prompt = "FlashPrompt",
--       },
--     },
--   },
--   config = function(_, opts)
--     require("flash").setup(opts)
--
--     -- 保留默认风格
--     vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "Comment" })
--     vim.api.nvim_set_hl(0, "FlashPrompt", { link = "MsgArea" })
--     vim.api.nvim_set_hl(0, "FlashPromptIcon", { link = "Special" })
--     vim.api.nvim_set_hl(0, "FlashCursor", { link = "Cursor" })
--
--     -- 接近默认 Search，但稍微更清楚一点
--     vim.api.nvim_set_hl(0, "FlashMatch", {
--       fg = "#1f2335",
--       bg = "#e0af68",
--       bold = false,
--     })
--
--     -- 接近默认 IncSearch，但更深一点
--     vim.api.nvim_set_hl(0, "FlashCurrent", {
--       fg = "#ffffff",
--       bg = "#7a5c00",
--       bold = false,
--     })
--
--     -- 接近默认 Substitute，但更容易看清
--     vim.api.nvim_set_hl(0, "FlashLabel", {
--       fg = "#ffffff",
--       bg = "#c03c44",
--       bold = true,
--     })
--   end,
-- }
return {
  "folke/flash.nvim",
  opts = {
    highlight = {
      backdrop = true,
      groups = {
        match = "FlashMatch",
        current = "FlashCurrent",
        label = "FlashLabel",
      },
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)

    vim.api.nvim_set_hl(0, "FlashMatch", {
      fg = "#FFFFFF",
      bg = "#5A3E85",
      bold = false,
    })

    vim.api.nvim_set_hl(0, "FlashCurrent", {
      fg = "#FFFFFF",
      bg = "#1F6F78",
      bold = false,
    })

    vim.api.nvim_set_hl(0, "FlashLabel", {
      fg = "#FFFFFF",
      bg = "#A61E4D",
      bold = true,
    })
  end,
}

-- return {
--   "folke/flash.nvim",
--   opts = {
--     highlight = {
--       backdrop = true,
--       groups = {
--         match = "FlashMatch",
--         current = "FlashCurrent",
--         label = "FlashLabel",
--       },
--     },
--   },
--   config = function(_, opts)
--     require("flash").setup(opts)
--
--     vim.api.nvim_set_hl(0, "FlashMatch", {
--       fg = "#B8B5FF",
--       bg = "#4A47A3",
--       bold = false,
--     })
--
--     vim.api.nvim_set_hl(0, "FlashCurrent", {
--       fg = "#D0E8F2",
--       bg = "#456268",
--       bold = false,
--     })
--
--     vim.api.nvim_set_hl(0, "FlashLabel", {
--       fg = "#EEF5FF",
--       bg = "#A25772",
--       bold = true,
--     })
--   end,
-- }
