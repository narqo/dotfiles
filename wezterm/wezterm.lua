local wz = require 'wezterm'
local config = {}

config.font = wz.font('Iosevka')
config.font_size = 16.0

config.audible_bell = 'Disabled'
config.default_cursor_style = 'SteadyBar'
config.cursor_thickness = 1
config.native_macos_fullscreen_mode = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.color_scheme = 'Umka'
config.colors = {
    copy_mode_active_highlight_bg = { Color = '#ffffd7' },
    copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    --copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
    --copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },
    copy_mode_inactive_highlight_bg = { Color = '#ffffd7' },
    copy_mode_inactive_highlight_fg = { AnsiColor = 'Black' },
}

config.keys = {
    {
        key = 'w',
        mods = 'CMD',
        action = wz.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'd',
        mods = 'CMD',
        action = wz.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'D',
        mods = 'SHIFT|CMD',
        action = wz.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '[',
        mods = 'CMD',
        action = wz.action.ActivatePaneDirection 'Prev',
    },
    {
        key = ']',
        mods = 'CMD',
        action = wz.action.ActivatePaneDirection 'Next',
    },
}

return config
