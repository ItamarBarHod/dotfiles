local settings = require("settings")

-- Left items (L to R)
require("items.flash_space")

-- Right items (R to L)
require("items.calendar")
sbar.add("item", "right.spacer", {
    position = "right",
    width = settings.space.md,
    background = { drawing = false },
})
require("items.widgets")
