local dashboard_image = vim.fn.stdpath("config") .. "/asset/ahriheadw.jpeg"
local dashboard_width = 60
local dashboard_image_max_width = 50
local dashboard_image_max_height = 14

local function dashboard_image_placeholder()
  local lines = {}
  local line = (" "):rep(dashboard_width)

  for _ = 1, dashboard_image_max_height do
    lines[#lines + 1] = line
  end

  return table.concat(lines, "\n")
end

local function dashboard_image_size(placement)
  local ok, size = pcall(Snacks.image.util.fit, placement.img.file, {
    width = dashboard_image_max_width,
    height = dashboard_image_max_height,
  }, {
    info = placement.img.info,
  })

  return ok and size or { width = dashboard_image_max_width, height = dashboard_image_max_height }
end

local function render_dashboard_image(self, pos)
  local row = pos[1]

  Snacks.image.placement.clean(self.buf)
  Snacks.image.terminal.detect(function()
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(self.buf) or not vim.api.nvim_win_is_valid(self.win) then
        return
      end
      if not Snacks.image.supports(dashboard_image) then
        return
      end

      Snacks.image.placement.clean(self.buf)
      Snacks.image.placement.new(self.buf, dashboard_image, {
        pos = { row, pos[2] },
        width = dashboard_image_max_width,
        height = dashboard_image_max_height,
        conceal = true,
        inline = true,
        on_update_pre = function(placement)
          local size = dashboard_image_size(placement)
          local col = pos[2] + math.max(0, math.floor((dashboard_width - size.width) / 2))

          placement.opts.pos = { row, col }
          placement.opts.range = { row, col, row + size.height - 1, col + size.width }
        end,
      })
    end)
  end)
end

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      ---@class snacks.dashboard.Config
      ---@field enabled? boolean
      ---@field sections snacks.dashboard.Section
      ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
      width = dashboard_width,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        -- pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        -- keys = {
        --   { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        --   { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        --   { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        --   { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        --   {
        --     icon = " ",
        --     key = "c",
        --     desc = "Config",
        --     action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        --   },
        --   { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        --   { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        --   { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        -- },
        -- Used by the `header` section
        header = [[
   █████████  █████                 █████     █████                         ███  
  ███▒▒▒▒▒███▒▒███                 ▒▒███     ▒▒███                         ▒▒███ 
 ███     ▒▒▒  ▒███████   █████ ████ ▒███████  ▒███████  █████ ████    ██    ▒▒███
▒███          ▒███▒▒███ ▒▒███ ▒███  ▒███▒▒███ ▒███▒▒███▒▒███ ▒███    ▒▒      ▒███
▒███          ▒███ ▒███  ▒███ ▒███  ▒███ ▒███ ▒███ ▒███ ▒███ ▒███            ▒███
▒▒███     ███ ▒███ ▒███  ▒███ ▒███  ▒███ ▒███ ▒███ ▒███ ▒███ ▒███            ███ 
 ▒▒█████████  ████ █████ ▒▒████████ ████████  ████████  ▒▒███████     ██    ██▒  
  ▒▒▒▒▒▒▒▒▒  ▒▒▒▒ ▒▒▒▒▒   ▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒    ▒▒▒▒▒███    ▒▒    ▒▒▒   
                                                         ███ ▒███                
                                                        ▒▒██████                 
                                                         ▒▒▒▒▒▒                  
]],
      },
      -- item field formatters
      formats = {
        icon = function(item)
          if item.file and item.icon == "file" or item.icon == "directory" then
            return Snacks.dashboard.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        -- { pane = 1, section = "header" },
        {
          pane = 1,
          text = dashboard_image_placeholder(),
          render = render_dashboard_image,
          padding = 1,
        },
        { pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 1,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        -- { pane = 1, section = "keys", gap = 1, padding = 1 },
        { pane = 1, section = "startup" },
      },
    },
  },
}
