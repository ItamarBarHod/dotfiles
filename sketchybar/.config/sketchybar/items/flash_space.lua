local settings = require("settings")
local colors = require("colors")

local FLASH_SPACE_CLI = "/Applications/FlashSpace.app/Contents/Resources/flashspace"

-- Workspace name → NerdFont icon mapping (using UTF-8 encoded codepoints)
local workspace_icons = {
    browser = utf8.char(0xeb01),
    code = utf8.char(0xf121),
    terminal = utf8.char(0xf489),
    messaging = utf8.char(0xf0ede),
    media = utf8.char(0xf500),
    laptop = utf8.char(0xf109),
}

-- Fetch workspaces dynamically and create items in the callback
sbar.exec(FLASH_SPACE_CLI .. " list-workspaces", function(result)
    if not result or result == "" then return end

    local item_names = {}

    for workspace_name in string.gmatch(result, "[^\r\n]+") do
        local icon = workspace_icons[workspace_name:lower()] or ""

        local item = sbar.add("item", "space." .. workspace_name, {
            position = "left",
            background = {
                color = colors.transparent,
                corner_radius = settings.space.xs,
                height = settings.bracket_height,
            },
            icon = {
                string = icon,
                color = colors.text,
                font = {
                    family = settings.font.nerd_icons,
                    style = settings.font.style_map["Regular"],
                    size = settings.font.sizes.nerd_icons,
                },
                padding_left = settings.space.lg,
                padding_right = settings.space.lg,
            },
            label = {
                drawing = false,
            },
            padding_left = settings.space.xs,
            padding_right = settings.space.xs,

        })

        item:subscribe("flashspace_workspace_change", function(env)
            local is_focused = env.WORKSPACE == workspace_name
            sbar.animate("linear", 16, function()
                item:set({
                    background = {
                        color = is_focused and colors.cyan or colors.transparent,
                    },
                    icon = {
                        color = is_focused and colors.background or colors.text,
                    },
                })
            end)
        end)

        table.insert(item_names, item.name)
    end

    -- Dark background behind the whole group
    sbar.add("bracket", "flash_spaces", item_names, {
        background = {
            color = colors.bar.bg,
            corner_radius = settings.space.xs,
            height = settings.bracket_height,
        },
    })

    -- Spacer between workspaces and front_app
    sbar.add("item", "left.spacer", {
        position = "left",
        width = settings.space.md,
        background = { drawing = false },
    })

    -- Front app (loaded here to guarantee ordering after async workspace items)
    require("items.front_app")
end)
