-- ~/.config/nvim/lua/plugins/snacks-image.lua
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.image = opts.image or {}
      opts.image.enabled = true

      opts.image.formats = opts.image.formats
        or {
          "png",
          "jpg",
          "jpeg",
          "gif",
          "bmp",
          "webp",
          "tiff",
          "heic",
          "avif",
          "mp4",
          "mov",
          "avi",
          "mkv",
          "webm",
          "pdf",
          "icns",
          "svg",
          "ico",
        }

      -- if not vim.tbl_contains(opts.image.formats, "svg") then
      --   table.insert(opts.image.formats, "svg")
      -- end
    end,
  },
}
-- return {
--   "folke/snacks.nvim",
--   priority = 1000,
--   lazy = false,
--   ---@type snacks.Config
--   opts = {
--     image = { enabled = true },
--     formats = {
--       "png",
--       "jpg",
--       "jpeg",
--       "gif",
--       "bmp",
--       "webp",
--       "tiff",
--       "heic",
--       "avif",
--       "mp4",
--       "mov",
--       "avi",
--       "mkv",
--       "webm",
--       "pdf",
--       "icns",
--       "svg",
--     },
--   },
-- }
