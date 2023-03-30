local t = require 'wezterm';
local act = t.action
local function builtin (name)
    return t.color.get_builtin_schemes()[name]
end

local originalList = { 'black', 'red', 'green', 'yellow', 'blue', 'purple', 'cyan', 'light gray' }

local myColors = {
    blueMain = '#7aa2f7',
    greenDark = '#1abc9c',
    orange = '#f14c28',
    pinkple = '#ec50fa',
    purpleDark = '#593af2',
    purpleLight = '#9398f5',
    red = '#f55385',
    teal = '#00ffcc',
    white = '#ffffff',
}

local eight = {
    myColors.teal,
    myColors.red,
    myColors.greenDark,
    myColors.blueMain,
    myColors.blueMain,
    myColors.purpleLight,
    myColors.pinkple,
    myColors.white,
}

local tokyo2 = builtin('tokyonight')
tokyo2.foreground = '#ffffff'
tokyo2.background = '#12131b'
tokyo2.ansi = eight
tokyo2.brights = eight
return {
    -- cell_width = 0.8,
    -- cell_width = 0.9,
    -- line_height = 0.9,
    -- color_scheme = "Ayu Mirage",
    -- color_scheme = "astromouse (terminal.sexy)",
    -- color_scheme = 'Bim (Gogh)',
    -- color_scheme = 'BlulocoDark',
    -- color_scheme = 'Brewer (base16)',
    -- color_scheme = 'Brogrammer',
    -- color_scheme = 'Cai (Gogh)',
    -- color_scheme = 'GoogleDark (Gogh)',
    -- color_scheme = 'Harmonic16 Dark (base16)',
    color_scheme = 'tokyo2',
    -- color_scheme = "tokyonight",
    color_schemes = {
        ['tokyo2'] = tokyo2
    },
    -- default_prog = { 'powershell.exe' },
    default_prog = {'zsh'},
    disable_default_key_bindings = true,
    font = t.font '{{ monoFont }}',
    font_size = {{ monoFontSize }},
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        { key = "c", mods = "CTRL|ALT", action = act.CopyTo("Clipboard") },
        { key = "d", mods = "CTRL|ALT", action = act.ActivateCopyMode },
        { key = "f", mods = "CTRL|ALT", action = act.Search { CaseInSensitiveString = "" } },
        { key = "n", mods = "CTRL|ALT", action = "SpawnWindow" },
        { key = "r", mods = "CTRL|ALT", action = "ReloadConfiguration" },
        { key = "t", mods = "CTRL", action = act.ActivateTabRelative(1) },
        { key = "t", mods = "CTRL|ALT", action = act.SpawnTab("CurrentPaneDomain") },
        { key = "v", mods = "CTRL|ALT", action = act.PasteFrom("Clipboard") },
        { key = "w", mods = "CTRL|ALT", action = act.CloseCurrentTab { confirm = true } },
        { key = "9", mods = "CTRL", action = "DecreaseFontSize" },
        { key = "0", mods = "CTRL", action = "IncreaseFontSize" },
    },
    tab_max_width = 68,
    use_fancy_tab_bar = false,
    window_padding = {
        top = 0,
        right = 0,
        bottom = 0,
        left = 0,
    }
}
-- && || -> --> --> => ==> == != <> < > </> /> 
-- wezterm ls-fonts --list-system
