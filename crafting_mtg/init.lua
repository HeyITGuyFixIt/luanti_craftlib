crafting_mtg = {
    path = core.get_modpath(core.get_current_modname()),
    tool_bases = {
        axe = { "group:soil", "group:stone", "group:tree", "group:wood" },
        hand = { "crafting_mtg:crafttable" }
    }
}

dofile(crafting_mtg.path .. "/craft_table.lua")
dofile(crafting_mtg.path .. "/default.lua")
