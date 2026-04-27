-- 解决切换buffer后图片消失的问题 refresh image
return {
  {
    "folke/snacks.nvim",
    opts = function()
      local group = vim.api.nvim_create_augroup("refresh_snacks_image_buffer", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "TabEnter" }, {
        group = group,
        callback = function()
          vim.schedule(function()
            local buf = vim.api.nvim_get_current_buf()
            local file = vim.api.nvim_buf_get_name(buf)

            if file == "" then
              return
            end

            if Snacks and Snacks.image and Snacks.image.supports_file(file) and vim.bo[buf].filetype == "image" then
              Snacks.image.placement.clean(buf)
              Snacks.image.buf.attach(buf)
              vim.cmd("redraw!")
            end
          end)
        end,
      })
    end,
  },
}
