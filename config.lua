Crafting = {}
-- You can configure locations here
Crafting.Locations = {
    [1] = {x = 1015.003, y = -3158.878, z = -38.907},
    [2] = {x = 1175.433, y = 2635.81, z = 37.755},
    [3] = {x = -1154.895, y = -2022.624, z = 13.176},
}
--[[
    You can add or remove if you want, be sure to use the right format like this:
    ["item_name"] = {
        label = "Item Label",
        needs = {
            ["item_to_use_name"] = {label = "Item Use Label", count = 1}, 
            ["item_to_use_name2"] = {label = "Item Use Label", count = 2},
        },
        threshold = 0,
    },

    #! 
        Threshold level is a level that gets saved (in the database) by crafting, if you craft succefully you gain points, if you fail you lose points.
        The threshold level can be changed to your liking.
    #!

    Also if you don't have the items below make sure to remove it and create your own version.
]]--
Crafting.Items = {
    ["simplelockpick"] = {
        label = "Small lockpick",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 1},
            ["plastic"] = {label = "Plastic", count = 2},
        },
        threshold = 0,
    },
    ["lockpick"] = {
        label = "Lockpick",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 2},
            ["plastic"] = {label = "Plastic", count = 4},
            ["wood"] = {label = "Wood", count = 1},
        },
        threshold = 100,
    },
    ["superlockpick"] = {
        label = "Advanced lockpick",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 4},
            ["plastic"] = {label = "Plastic", count = 6},
            ["stone"] = {label = "Stone", count = 1},
            ["wood"] = {label = "Wood", count = 1},
        },
        threshold = 200,
    },
    ["handcuffs"] = {
        label = "Handcuffs",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 5},
            ["simplelockpick"] = {label = "Small lockpick", count = 1},
        },
        threshold = 250,
    },
    ["drill"] = {
        label = "Drill",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 10},
            ["plastic"] = {label = "Plastic", count = 18},
            ["rubber"] = {label = "Rubber", count = 6},
            ["stone"] = {label = "Stone", count = 8},
        },
        threshold = 250,
    },
    ["fixkit"] = {
        label = "Repair kit",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 5},
            ["plastic"] = {label = "Plastic", count = 12},
            ["rubber"] = {label = "Rubber", count = 5},
            ["wood"] = {label = "Wood", count = 8},
        },
        threshold = 350,
    },
    ["weapon_pistol"] = {
        label = "Pistol",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 18},
            ["plastic"] = {label = "Plastic", count = 30},
            ["rubber"] = {label = "Rubber", count = 8},
            ["superlockpick"] = {label = "Advanced lockpick", count = 1},
        },
        threshold = 450,
    },
    ["clip"] = {
        label = "Ammo clip",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 10},
            ["copper"] = {label = "Copper", count = 5},
            ["lockpick"] = {label = "Lockpick", count = 1},
        },
        threshold = 450,
    },
    ["weapon_combatpistol"] = {
        label = "Combat Pistol",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 22},
            ["plastic"] = {label = "Plastic", count = 36},
            ["rubber"] = {label = "Rubber", count = 10},
            ["superlockpick"] = {label = "Advanced lockpick", count = 1},
        },
        threshold = 600,
    },
}