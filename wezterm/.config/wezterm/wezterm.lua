-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = true

-- 设置 Tab 栏部分的背景色（未被 Tab 占据的空白处）
config.colors = {
  tab_bar = {
    background = '#0b0022', -- 对应你代码里的深紫色背景
  },
}

-- customize tab bar
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)

  -- 定义状态颜色
  local background = '#3c1361' -- 默认背景色
  local foreground = '#c0c0c0' -- 默认前景色

  if tab.is_active then
    background = '#52307c'
    foreground = '#ffffff'
  elseif hover then
    background = '#3c1361'
    foreground = '#909090'
  end

  local edge_background = '#0b0022' -- 必须匹配 config.colors.tab_bar.background

  -- 获取当前 Tab 的标题
  local title = tab.active_pane.title

  return {
    -- 2. Tab 内容 (包含 Padding)
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = ' ' .. title .. ' ' },
  }
end)


-- scroll bar
config.enable_scroll_bar = true

-- font
config.font = wezterm.font("JetBrainsMonoNL NF", { weight = "Regular", italic = ture })
config.font_size = 10

-- background
-- config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 40
-- config.win32_system_backdrop = "Acrylic"

-- windows
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"

-- config.window_close_confirmation = "NeverPrompt"

-- colour scheme
-- Find them here: https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = "Tokyo Night"

-- Sets the font for the window frame
-- only effective for fancy bar
-- config.window_frame = {
	-- font = wezterm.font({ family = "JetBrainsMonoNL NF", weight = "Regular" }),
-- }

-- padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- change default shell
-- config.default_prog = { "pwsh.exe" }

-- window_frame
config.initial_cols = 160
config.initial_rows = 40

-- key binding
-- full screen
config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
	    	key = 'w',
	    	mods = 'CTRL',
	    	action = wezterm.action.CloseCurrentTab { confirm = true},
	},
}
-- close window

-- re-pos
wezterm.on("window-config-reloaded", function(window, pane)
	window:set_position(150, 20)
end)


-- lauch_menu 鼠标右键new tab键的menu
config.launch_menu = {
  {
    label = '生产服务器 - Web01',
    args = { 'ssh', 'user@192.168.1.10' },
  },
  {
    label = '开发环境 - Dev',
    args = { 'ssh', 'dev-box' },
  },
}


-- return the configuration to wezterm
return config
